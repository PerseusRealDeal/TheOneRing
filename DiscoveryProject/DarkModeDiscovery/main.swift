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

// MARK: - The log report

func report(_ instance: PerseusDarkMode.LogMessage) {

    let date = instance.localTime.date
    let time = instance.localTime.time

    localReport.lastMessage = "[\(date)] [\(time)] \(instance.text)"
}

func report(_ instance: PerseusGeoKit.LogMessage) {

    let date = instance.localTime.date
    let time = instance.localTime.time

    localReport.lastMessage = "[\(date)] [\(time)] \(instance.text)"
}

let localReport = ConsolePerseusLogger.PerseusLogger.Report()

// MARK: - The logger

GEO_LOG.customActionOnMessage = report(_:)
DM_LOG.customActionOnMessage = report(_:)

log.customActionOnMessage = localReport.report(_:)

log.message("The app's start point...", .info)

// MARK: - The app run

let globals = AppGlobals()

// Determine the app run purpose
let appPurpose: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

// Initialize the app object from the purpose
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appPurpose))
