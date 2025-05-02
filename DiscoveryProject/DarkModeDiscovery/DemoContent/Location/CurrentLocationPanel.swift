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
import PerseusDarkMode
import PerseusGeoKit

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

        labelPermissionValue.text = "\(GeoAgent.currentStatus)".capitalized

        GeoAgent.shared.requestPermission { permit in
            if permit != .allowed, let vc = self.parentViewController() {
                GeoAgent.showRedirectAlert(vc, REDIRECT_ALERT_TITLES)
            }
        }
    }

    @IBAction func buttonRefreshCurrentTapped(_ sender: UIButton) {
        do {
            try GeoAgent.shared.requestCurrentLocation()
        } catch LocationError.permissionRequired(let permit) {

            log.message("[\(type(of: self))].\(#function) permission required", .notice)

            if permit == .notDetermined {
                GeoAgent.shared.requestPermission()
            } else if let vc = self.parentViewController() {
                GeoAgent.showRedirectAlert(vc, REDIRECT_ALERT_TITLES)
            }

        } catch {
            log.message("[\(type(of: self))].\(#function) something totally wrong", .error)
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

        GeoAgent.register(self, #selector(currentLocationHandler(_:)), .currentLocation)
        GeoAgent.register(self, #selector(locationStatusHandler(_:)), .locationStatus)
        GeoAgent.register(self, #selector(locationErrorHandler(_:)), .locationError)
        GeoAgent.register(self, #selector(locationUpdatesHandler(_:)), .locationUpdates)

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

    @objc private func currentLocationHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function) [EVENT]", .info)

        guard let result = notification.object as? Result<GeoPoint, LocationError>
        else {
            log.message("[\(type(of: self))].\(#function) [EVENT]", .error)
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

    @objc private func locationStatusHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function) [EVENT]", .info)
        refresh()
    }

    @objc private func locationErrorHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function) [EVENT]", .info)

        guard
            let result = notification.object as? LocationError,
            let failedRequestDetails = result.failedRequestDetails
        else {
            log.message("[\(type(of: self))].\(#function) no error details", .error)
            return
        }

        switch failedRequestDetails.code {
        case 0: log.message("Connection issue takes place.", .notice)
        case 1: log.message("Deal with permission required.", .notice)
        default:
            break
        }
    }

    @objc private func locationUpdatesHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function) [EVENT]", .info)

        guard
            let result = notification.object as? Result<[GeoPoint], LocationError>
        else {
            log.message("[\(type(of: self))].\(#function) [EVENT]", .error)
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
        labelPermissionValue.text = "\(GeoAgent.currentStatus)".capitalized
        labelGeoCoupleValue.text = geoCouple
    }

    private func callDarkModeSensitiveColours() {
        labelPermissionValue.textColor = .customLabel
        labelGeoCoupleValue.textColor = .customLabel
    }
}
