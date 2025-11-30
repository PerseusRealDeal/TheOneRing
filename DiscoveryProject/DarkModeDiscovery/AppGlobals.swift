//
//  AppGlobals.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import Foundation

import ConsolePerseusLogger
import PerseusGeoKit

// MARK: - Geo Constants

var DEFAULT_GEO_POINT: String { "\(DEFAULT_MAP_POINT.point)" }
var CURRENT_GEO_POINT: String {

    guard let point = AppGlobals.currentLocation else {
        return "Latitude, Longitude"
    }

    return "\(point)"
}

var CURRENT_LOCATION: String {
    return AppGlobals.currentLocation == nil ? DEFAULT_GEO_POINT : CURRENT_GEO_POINT
}

// MARK: - App Globals

struct AppGlobals {

    // MARK: - Business Data

    static var currentLocation: GeoPoint? {
        didSet {
            let location = currentLocation?.description ?? "current location is erased"
            log.message("\(location) \(#function)", .info)
            GEO_LOG.message("\(location) \(#function)", .debug, .custom)
        }
    }

    // MARK: - System Services

    static let userDefaults = UserDefaults.standard
    static let notificationCenter = NotificationCenter.default

    // MARK: - Initializer

    init() {
        log.message("[\(type(of: self))].\(#function)", .info)

        GeoAgent.currentAccuracy = .best

        GeoCoordinator.shared.onStatusAllowed = {
            // LocationDealer.requestCurrent()
            LocationDealer.requestUpdatingLocation()
        }
        GeoCoordinator.shared.notifier = AppGlobals.notificationCenter

        GeoCoordinator.shared.locationRecieved = { point in
            AppGlobals.currentLocation = point
        }

        GeoCoordinator.shared.locationUpdatesRecieved = { updates in
            if let lastone = updates.last {
                log.message("Location Updates: \(updates.count)")
                GEO_LOG.message("Location Updates: \(updates.count)", .debug, .custom)
                AppGlobals.currentLocation = lastone
            }
        }
    }
}

func loadJsonLogProfile(_ name: String) -> (status: Bool, info: String) {

    if let path = Bundle.main.url(forResource: name, withExtension: "json") {
        if log.loadConfig(path), DM_LOG.loadConfig(path), GEO_LOG.loadConfig(path) {
            return (true, "Options successfully reseted")
        } else {
            return (false, "Failed to reset options")
        }
    } else {
        return (false, "Failed to create URL")
    }
}
