//
//  AppGlobals.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7533 (28.12.2024).
//
//  Copyright © 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import Foundation

import ConsolePerseusLogger
import PerseusGeoKit

struct AppGlobals {

    // MARK: - Business Data

    static var currentLocation: GeoPoint? {
        didSet {
            let location = currentLocation?.description ?? "current location is erased"
            log.message("\(location) [\(type(of: self))].\(#function)", .info)
        }
    }

    // MARK: - System Services

    static let userDefaults = UserDefaults.standard
    static let notificationCenter = NotificationCenter.default

    // MARK: - Custom Services

    static let geoCoordinator = GeoCoordinator.shared

    // MARK: - Initializer

    init() {
        log.message("[\(type(of: self))].\(#function)", .info)
        GeoAgent.currentAccuracy = PREFERED_ACCURACY
        AppGlobals.geoCoordinator.reloadGeoComponents()
    }
}
