//
//  main.swift, LaunchScreen.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit
import ConsolePerseusLogger

import class PerseusDarkMode.PerseusLogger
import class PerseusGeoKit.PerseusLogger

// swiftlint:disable type_name
typealias DM_LOG = PerseusDarkMode.PerseusLogger
typealias GEO_LOG = PerseusGeoKit.PerseusLogger
// swiftlint:enable type_name

// MARK: - Log Report

// swiftlint:disable:next function_parameter_count
func report(_ text: String,
            _ type: DM_LOG.Level,
            _ localTime: DM_LOG.LocalTime,
            _ owner: DM_LOG.PIDandTID,
            _ user: DM_LOG.User,
            _ dirs: DM_LOG.Directives) {

    localReport.lastMessage = "[\(localTime.date)] [\(localTime.time)] \(text)"
}

// swiftlint:disable:next function_parameter_count
func report(_ text: String,
            _ type: GEO_LOG.Level,
            _ localTime: GEO_LOG.LocalTime,
            _ owner: GEO_LOG.PIDandTID,
            _ user: GEO_LOG.User,
            _ dirs: GEO_LOG.Directives) {

    localReport.lastMessage = "[\(localTime.date)] [\(localTime.time)] \(text)"
}

let localReport = ConsolePerseusLogger.PerseusLogger.Report()

// MARK: - Logger

GEO_LOG.customActionOnMessage = report(_:_:_:_:_:_:)
DM_LOG.customActionOnMessage = report(_:_:_:_:_:_:)

log.customActionOnMessage = localReport.report(_:_:_:_:_:_:)

// log.turned = .off
// dmlog.turned = .off
// geolog.turned = .off

/*
var isLoadedInfo = ""

if let path = Bundle.main.url(forResource: "CPLConfig", withExtension: "json") {
    if log.loadConfig(path), dmlog.loadConfig(path), geolog.loadConfig(path) {
        isLoadedInfo = "Options successfully reseted!"
    } else {
        isLoadedInfo = "Failed to reset options!"
    }
} else {
    isLoadedInfo = "Failed to create URL!"
}

log.message(isLoadedInfo)
*/

log.message("The app's start point...", .info)

// MARK: - Run the app

let globals = AppGlobals()

// Determine the app run purpose
let appPurpose: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

// Initialize the app object from the purpose
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appPurpose))
