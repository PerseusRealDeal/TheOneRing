//
//  CurrentLocationPanel.swift, CurrentLocationPanel.xib
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7533 (02.01.2025).
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit
import ConsolePerseusLogger

import PerseusGeoLocationKit
import PerseusDarkMode

class CurrentLocationPanel: UIView {

    // MARK: - Interface Builder connections

    /// Outlet of the content view.
    @IBOutlet private weak var contentView: UIView!

    @IBOutlet private weak var buttonRefreshStatus: UIButton!
    @IBOutlet private weak var buttonCurrentLocation: UIButton!

    @IBOutlet private weak var labelPermissionValue: UILabel!
    @IBOutlet private weak var labelGeoCoupleValue: UILabel!

    @IBAction func buttonRefreshStatusTapped(_ sender: UIButton) {
        let permit = globals.locationDealer.locationPermit
        labelPermissionValue.text = "\(permit)".capitalized

        log.message("Location access \(permit)")

        if permit == .notDetermined {
            // Allow geo service action.
            globals.locationDealer.requestPermission()
        }
    }

    @IBAction func buttonRefreshLocationTapped(_ sender: UIButton) {
        let permit = globals.locationDealer.locationPermit

        if permit == .notDetermined {
            // Allow geo service action.
            globals.locationDealer.requestPermission()
        } else if permit == .allowed {
            // Refresh geo data action.
            try? globals.locationDealer.requestCurrentLocation()
        } else if let vc = self.parentViewController() {
            // Open system options action.
            globals.locationDealer.alert.show(parent: vc)
        }
    }

    // MARK: - Initiating

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
        configure()
    }

    // MARK: - Setup user control

    /// Constructs the user control.
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)

        addSubview(contentView)

        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(
                equalTo: widthAnchor,
                constant: .zero
            ),
            contentView.heightAnchor.constraint(
                equalTo: heightAnchor,
                constant: .zero
            )
        ])

        // Setup location event handlers.

        let nc = AppGlobals.notificationCenter

        nc.addObserver(self, selector: #selector(locationDealerCurrentHandler(_:)),
                       name: .locationDealerCurrentNotification,
                       object: nil)

        nc.addObserver(self, selector: #selector(locationDealerStatusChangedHandler),
                       name: .locationDealerStatusChangedNotification,
                       object: nil)

        nc.addObserver(self, selector: #selector(locationDealerErrorHandler),
                       name: .locationDealerErrorNotification,
                       object: nil)

        // Dark Mode setup

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        if DarkModeAgent.isEnabled { makeUp() }
    }

    // MARK: - Configure connected Interface Builder elements

    /// Configurates the user control.
    private func configure() {
        buttonRefreshStatus.layer.cornerRadius = 8
        buttonRefreshStatus.layer.masksToBounds = true
        buttonCurrentLocation.layer.cornerRadius = 8
        buttonCurrentLocation.layer.masksToBounds = true
    }

    /// Updates the appearance of the user control.
    @objc private func makeUp() {
        buttonRefreshStatus.backgroundColor = .customSecondaryBackground
        buttonCurrentLocation.backgroundColor = .customSecondaryBackground
    }
}

extension CurrentLocationPanel {

    private var geoCouple: String {
        guard let location = AppGlobals.currentLocation
        else {
            return "Latitude, Longitude"
        }

        return "\(location.latitude.cut(.four)), \(location.longitude.cut(.four))"
    }

    @objc private func locationDealerCurrentHandler(_ notification: Notification) {
        log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)")

        guard
            let result = notification.object as? Result<PerseusLocation, LocationError>
        else {
            log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)", .error)
            return
        }

        switch result {
        case .success(let data):
            AppGlobals.currentLocation = data
        case .failure(let error):
            log.message("\(error)", .error)
        }

        refresh()
    }

    @objc private func locationDealerStatusChangedHandler() {
        log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)")
        refresh()
    }

    @objc private func locationDealerErrorHandler() {
        log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)", .error)
    }

    private func refresh() {
        let permit = "\(globals.locationDealer.locationPermit)".capitalized

        labelPermissionValue.text = permit
        labelGeoCoupleValue.text = geoCouple
    }

    private func callDarkModeSensitiveColours() {
        labelPermissionValue.textColor = .customLabel
        labelGeoCoupleValue.textColor = .customLabel
    }
}
