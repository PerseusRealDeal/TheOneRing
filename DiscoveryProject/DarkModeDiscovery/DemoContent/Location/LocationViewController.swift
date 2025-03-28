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

class LocationViewController: UIViewController {

    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var mapView: MKMapView!

    @IBAction func actionButtonCloseTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard value(forKey: "storyboardIdentifier") != nil else { return }

        configure()

        // Dark Mode setup
        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        if DarkModeAgent.isEnabled { makeUp() }
    }

    private func configure() {
        buttonClose.layer.cornerRadius = 5
        buttonClose.clipsToBounds = true

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
    }
}
