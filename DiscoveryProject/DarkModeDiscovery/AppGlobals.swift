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

import PerseusGeoLocationKit

struct AppGlobals {

    // MARK: - Business Data

    static var currentLocation: PerseusLocation? {
        didSet {
            let location = currentLocation?.description ?? "current location is cleared"
            log.message("\(location) [\(type(of: self))].\(#function)", .info)
        }
    }

    // MARK: - System Services

    static let userDefaults = UserDefaults.standard
    static let notificationCenter = NotificationCenter.default

    // MARK: - Custom Services

    public let locationDealer: LocationAgent

    // MARK: - Initializer

    init() {
        log.message("[\(type(of: self))].\(#function)", .info)

        locationDealer = LocationAgent.shared
    }

    // MARK: - Contract

    static func openTheApp(name: String) {
    }
}
