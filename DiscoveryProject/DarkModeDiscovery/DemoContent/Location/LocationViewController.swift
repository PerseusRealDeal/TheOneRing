//
//  LocationViewController.swift, LocationViewController.storyboard
//  TheOneRing
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//
//
// swiftlint:disable file_length
//

import UIKit
import MapKit

import ConsolePerseusLogger
import PerseusDarkMode
import PerseusGeoKit

class LocationViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var buttonRefreshPermissionStatus: UIButton!
    @IBOutlet weak var buttonGoToPoint: UIButton!
    @IBOutlet weak var buttonStartUpdating: UIButton!
    @IBOutlet weak var buttonStopUpdating: UIButton!
    @IBOutlet weak var buttonCrurrentLocation: UIButton!
    @IBOutlet weak var switchAutoMapToCurrent: UISwitch!

    @IBOutlet weak var labelCoordinate: UILabel!
    @IBOutlet weak var labelGeoStatus: UILabel!

    @IBOutlet weak var textViewLog: UITextView!

    private var observation: NSKeyValueObservation?

    private var autoMapToCurrent = true

    // MARK: - Actions

    @IBAction func actionButtonCloseTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func actionButtonStatusTapped(_ sender: UIButton) {

        log.message(#function, .debug, .custom)

        labelGeoStatus.text = "\(GeoAgent.aboutLocationServices().inDetail)".capitalized

        if GeoAgent.currentStatus == .allowed {
            REDIRECT_ALERT_TITLES.title = REDIRECT_ALERT_TITLES.titleWithStatus
            GeoAgent.showRedirectAlert(self, REDIRECT_ALERT_TITLES)  // Offer redirect.
        } else {
            LocationDealer.requestPermission(self)
        }
    }

    @IBAction func actionButtonGoToPointTapped(_ sender: UIButton) {
        mapToCurrent()
    }

    @IBAction func actionButtonStartUpdatingTapped(_ sender: UIButton) {

        log.message(#function, .debug, .custom)

        LocationDealer.requestUpdatingLocation()
    }

    @IBAction func actionButtonStopUpdatingTapped(_ sender: UIButton) {

        log.message(#function, .debug, .custom)

        GeoAgent.shared.stopUpdatingLocation()
    }

    @IBAction func actionButtonCrurrentLocationTapped(_ sender: UIButton) {

        log.message(#function, .debug, .custom)

        LocationDealer.requestCurrent(self)
    }

    @IBAction func actionSwitchAutoMapToCurrentTapped(_ sender: UISwitch) {

        log.message(#function, .debug, .custom)

        autoMapToCurrent = sender.isOn ? true : false
    }

    // MARK: - Start

    override func viewDidLoad() {
        super.viewDidLoad()
        guard value(forKey: "storyboardIdentifier") != nil else { return }

        configure()

        // Connect to Geo Coordinator
        GeoCoordinator.register(stakeholder: self, selector: #selector(reload))

        // Connect to Dark Mode explicitly
        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp() // That's for now, call if not the first, main, screen.

        // Connect to Log Reporting
        observation = localReport.observe(\.lastMessage) { _, _ in // Always in main thread?
            // DispatchQueue.main.async { } // No
            self.refreshLogReportTextView() // Yes
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        reload()
        refreshLogReportTextView()
    }

    private func configure() {

        buttonClose.layer.cornerRadius = 5
        buttonClose.clipsToBounds = true

        buttonRefreshPermissionStatus.layer.cornerRadius = 5
        buttonRefreshPermissionStatus.clipsToBounds = true

        buttonGoToPoint.layer.cornerRadius = 5
        buttonGoToPoint.clipsToBounds = true

        buttonStartUpdating.layer.cornerRadius = 5
        buttonStartUpdating.clipsToBounds = true

        buttonStopUpdating.layer.cornerRadius = 5
        buttonStopUpdating.clipsToBounds = true

        buttonCrurrentLocation.layer.cornerRadius = 5
        buttonCrurrentLocation.clipsToBounds = true

        switchAutoMapToCurrent.setOn(autoMapToCurrent, animated: false)
    }
}

// MARK: - Implementation

extension LocationViewController {

    @objc private func reload() {

        labelGeoStatus.text = "\(GeoAgent.aboutLocationServices().inDetail)".capitalized

        if AppGlobals.currentLocation == nil {
            labelCoordinate.text = "Default: \(DEFAULT_GEO_POINT)"
            mapView.setRegion(DEFAULT_VISIBLE_REGION, animated: true)

            return
        }

        labelCoordinate.text = CURRENT_LOCATION

        if autoMapToCurrent {
            mapToCurrent()
        }
    }

    private func mapToCurrent() {
        let point = AppGlobals.currentLocation ?? GeoPoint(DEFAULT_MAP_POINT)

        let location = CLLocation(latitude: point.latitude, longitude: point.longitude)
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: DEFAULT_MAP_RADIUS,
                                        longitudinalMeters: DEFAULT_MAP_RADIUS)

        log.message("\(point)", .debug, .custom)

        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }

    @objc private func makeUp() {
        view.backgroundColor = .customPrimaryBackground

        buttonClose.backgroundColor = .customSecondaryBackground

        buttonRefreshPermissionStatus.backgroundColor = .customSecondaryBackground
        buttonGoToPoint.backgroundColor = .customSecondaryBackground
        buttonStartUpdating.backgroundColor = .customSecondaryBackground
        buttonStopUpdating.backgroundColor = .customSecondaryBackground
        buttonCrurrentLocation.backgroundColor = .customSecondaryBackground

        labelCoordinate.textColor = .customLabel
        labelGeoStatus.textColor = .customLabel

        textViewLog.textColor = .customLabel
    }

    private func refreshLogReportTextView() {

        log.message("\(localReport.text.count)", .debug, .standard)

        textViewLog.text = localReport.text
        textViewLog.scrollToBottom()
    }
}

extension UITextView {
    func scrollToBottom() {
        if text.isEmpty { return }
        scrollRangeToVisible(NSRange(location: text.count - 1, length: 0))
    }
}
