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

    @IBOutlet weak var labelCoordinate: UILabel!
    @IBOutlet weak var labelGeoStatus: UILabel!

    // MARK: - Actions

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

    // MARK: - Start

    override func viewDidLoad() {
        super.viewDidLoad()
        guard value(forKey: "storyboardIdentifier") != nil else { return }

        configure()

        // Set the defualt visible area
        mapView.setRegion(DEFAULT_VISIBLE_REGION, animated: true)

        // Connect to Geo coordinator
        AppGlobals.geoCoordinator.mapViewController = self

        // Connect to Dark Mode explicitly
        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp() // That's for now, call if not the first, main, screen.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        reload()
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
    }

    // MARK: - Contract

    public func reloadData() {
        reload()
    }
}

// MARK: - Implementation

extension LocationViewController {

    private func reload() {
        labelGeoStatus.text = "Status: \(GeoAgent.currentStatus)".capitalized
        labelCoordinate.text = CURRENT_LOCATION
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
    }
}
