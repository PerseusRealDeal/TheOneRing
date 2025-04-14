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
// import PerseusDarkMode

class CurrentLocationPanel: UIView {

    private lazy var locationViewController = { () -> LocationViewController in

        let storyboard =
            UIStoryboard(name: String(describing: LocationViewController.self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as? LocationViewController

        /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
        return screen ?? LocationViewController()
    }()

    @IBAction func actionOpenMap(_ sender: UIButton) {
        guard let vc = self.parentViewController() else { return }

        vc.present(self.locationViewController, animated: true, completion: nil)
    }
    // MARK: - Interface Builder connections

    /// Outlet of the content view.
    @IBOutlet private weak var contentView: UIView!

    @IBOutlet private weak var buttonOpenMap: UIButton!
    @IBOutlet private weak var buttonRefreshStatus: UIButton!
    @IBOutlet private weak var buttonCurrentLocation: UIButton!

    @IBOutlet private weak var labelPermissionValue: UILabel!
    @IBOutlet private weak var labelGeoCoupleValue: UILabel!

    @IBAction func buttonRefreshStatusTapped(_ sender: UIButton) {
        let dealer = globals.locationDealer

        labelPermissionValue.text = "\(dealer.locationPermit)".capitalized

        dealer.requestPermission { permit in
            if permit != .allowed, let vc = self.parentViewController() {
                dealer.alert.show(using: vc)
            }
        }
    }

    @IBAction func buttonRefreshCurrentTapped(_ sender: UIButton) {
        let dealer = globals.locationDealer

        do {
            try dealer.requestCurrentLocation()
        } catch LocationError.permissionRequired(let permit) {

            log.message("[\(type(of: self))].\(#function) - permission required", .notice)

            if permit == .notDetermined {
                dealer.requestPermission()
            } else if let vc = self.parentViewController() {
                dealer.alert.show(using: vc)
            }

        } catch {
            log.message("[\(type(of: self))].\(#function) - something totally wrong", .error)
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

        LocationAgent.getNotified(with: self,
                                  selector: #selector(locationDealerCurrentHandler(_:)),
                                  name: .locationDealerCurrentNotification)

        LocationAgent.getNotified(with: self,
                                  selector: #selector(locationDealerStatusChangedHandler(_:)),
                                  name: .locationDealerStatusChangedNotification)

        LocationAgent.getNotified(with: self,
                                  selector: #selector(locationDealerErrorHandler(_:)),
                                  name: .locationDealerErrorNotification)

        LocationAgent.getNotified(with: self,
                                  selector: #selector(locationDealerUpdatesHandler(_:)),
                                  name: .locationDealerUpdatesNotification)

        // Dark Mode setup

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp()
    }

    // MARK: - Configure connected Interface Builder elements

    /// Configurates the user control.
    private func configure() {
        buttonRefreshStatus.layer.cornerRadius = 8
        buttonRefreshStatus.layer.masksToBounds = true
        buttonCurrentLocation.layer.cornerRadius = 8
        buttonCurrentLocation.layer.masksToBounds = true
        buttonOpenMap.layer.cornerRadius = 8
        buttonOpenMap.layer.masksToBounds = true
    }

    /// Updates the appearance of the user control.
    @objc private func makeUp() {
        buttonRefreshStatus.backgroundColor = .customSecondaryBackground
        buttonCurrentLocation.backgroundColor = .customSecondaryBackground
        buttonOpenMap.backgroundColor = .customSecondaryBackground
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
        log.message("[\(type(of: self))]:[NOTIFICATION].\(#function)", .info)

        guard
            let result = notification.object as? LocationError,
            let failedRequestDetails = result.failedRequestDetails
        else {
            log.message("[\(type(of: self))].\(#function) - no error details", .error)
            return
        }

        switch failedRequestDetails.code {
        case 0: log.message("Connection issue takes place.", .notice)
        case 1: log.message("Deal with permission required.", .notice)
        default:
            break
        }
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
