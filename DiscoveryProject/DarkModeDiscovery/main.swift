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

import struct PerseusDarkMode.LogMessage
import struct PerseusGeoKit.LogMessage

// swiftlint:disable type_name
typealias DM_LOG = PerseusDarkMode.PerseusLogger
typealias GEO_LOG = PerseusGeoKit.PerseusLogger
// swiftlint:enable type_name

// MARK: - The PerseusDarkMode Logger

func report(_ message: PerseusDarkMode.LogMessage) {
    let text = "[\(message.localTime.date)] [\(message.localTime.time)] \(message.text)"
    localReport.lastMessage = "SUB_DM: " + text
}

DM_LOG.customActionOnMessage = report(_:)
DM_LOG.output = .custom
// DM_LOG.turned = .off

// MARK: - The PerseusGeoKit Logger

func report(_ message: PerseusGeoKit.LogMessage) {
    let text = "[\(message.localTime.date)] [\(message.localTime.time)] \(message.text)"
    localReport.lastMessage = "SUB_GEO: " + text
}

GEO_LOG.customActionOnMessage = report(_:)
GEO_LOG.output = .custom
// GEO_LOG.turned = .off

// MARK: - The Logger

let localReport = ConsolePerseusLogger.PerseusLogger.Report()

log.customActionOnMessage = localReport.report(_:)
log.output = .custom
// log.turned = .off

// MARK: - The start line

log.message("The start line...", .info)

let globals = AppGlobals()
let appPurpose: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

// MARK: - The app's run

log.message("The app is about to run...", .info)

// Initialize the app object from the purpose
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appPurpose))
