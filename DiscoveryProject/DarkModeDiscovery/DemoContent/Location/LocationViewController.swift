//
//  LocationViewController.swift, LocationViewController.storyboard
//  TheOneRing
//
//  Created by Mikhail Zhigulin in 7533 (17.03.2025).
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit
import MapKit

import PerseusDarkMode
import ConsolePerseusLogger

class LocationViewController: UIViewController {

    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var buttonRefreshPermissionStatus: UIButton!
    @IBOutlet weak var buttonGoToPoint: UIButton!
    @IBOutlet weak var buttonStartUpdating: UIButton!
    @IBOutlet weak var buttonStopUpdating: UIButton!
    @IBOutlet weak var buttonCrurrentLocation: UIButton!

    @IBOutlet weak var labelCoordinate: UILabel!
    @IBOutlet weak var labelPermissionStatus: UILabel!

    @IBAction func actionButtonCloseTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func actionButtonStatusTapped(_ sender: UIButton) {
        log.message("\(#function)")
    }

    @IBAction func actionButtonGoToPointTapped(_ sender: UIButton) {
        log.message("\(#function)")
    }

    @IBAction func actionButtonStartUpdatingTapped(_ sender: UIButton) {
        log.message("\(#function)")
    }

    @IBAction func actionButtonStopUpdatingTapped(_ sender: UIButton) {
        log.message("\(#function)")
    }

    @IBAction func actionButtonCrurrentLocationTapped(_ sender: UIButton) {
        log.message("\(#function)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard value(forKey: "storyboardIdentifier") != nil else { return }

        configure()

        // Dark Mode setup
        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp()
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

        // Set the defualt visible area

        let point = CLLocation(latitude: 55.036857, longitude: 82.914063)
        let radius: CLLocationDistance = 1000

        let region = MKCoordinateRegion(center: point.coordinate,
                                        latitudinalMeters: radius,
                                        longitudinalMeters: radius)

        mapView.setRegion(region, animated: true)
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
        labelPermissionStatus.textColor = .customLabel
    }
}
