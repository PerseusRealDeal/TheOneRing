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
// swiftlint:disable file_length
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

        guard permit != .allowed else { return }

        let dealer = globals.locationDealer

        if permit == .notDetermined {
            // Deal with permission
            dealer.requestPermission()
        } else if let vc = self.parentViewController() {
            // Show GoTo Settings alert
            dealer.alert.show(using: vc)
        }
    }

    @IBAction func buttonRefreshLocationTapped(_ sender: UIButton) {
        let dealer = globals.locationDealer
        let permit = dealer.locationPermit

        if permit == .notDetermined {
            // Allow geo service action.
            dealer.requestPermission()
        } else if permit == .allowed {
            // Refresh geo data action.
            try? dealer.requestCurrentLocation()
        } else if let vc = self.parentViewController() {
            // Open system options action.
            dealer.alert.show(using: vc)
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

        nc.addObserver(self, selector: #selector(locationDealerStatusChangedHandler(_:)),
                       name: .locationDealerStatusChangedNotification,
                       object: nil)

        nc.addObserver(self, selector: #selector(locationDealerErrorHandler(_:)),
                       name: .locationDealerErrorNotification,
                       object: nil)

        nc.addObserver(self, selector: #selector(locationDealerUpdatesHandler(_:)),
                       name: .locationDealerUpdatesNotification,
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
        log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)", .info)

        guard let result = notification.object as? Result<PerseusLocation, LocationError>
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

    @objc private func locationDealerStatusChangedHandler(_ notification: Notification) {
        log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)", .info)
        refresh()
    }

    @objc private func locationDealerErrorHandler(_ notification: Notification) {
        log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)", .error)
    }

    @objc private func locationDealerUpdatesHandler(_ notification: Notification) {
        log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)", .info)

        guard
            let result = notification.object as? Result<[PerseusLocation], LocationError>
        else {
            log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)", .error)
            return
        }

        switch result {
        case .success(let data):
            AppGlobals.currentLocation = data.last
        case .failure(let error):
            log.message("\(error)", .error)
        }

        refresh()
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
