//
//  main.swift, LaunchScreen.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit
import ConsolePerseusLogger

import class PerseusDarkMode.PerseusLogger
import class PerseusGeoKit.PerseusLogger

// swiftlint:disable type_name
typealias dmlog = PerseusDarkMode.PerseusLogger
typealias geolog = PerseusGeoKit.PerseusLogger
// swiftlint:enable type_name

// MARK: - Log Reports

typealias GeologLevel = PerseusGeoKit.PerseusLogger.Level

class LocationServicesReport: NSObject {

    public var text: String { report }

    @objc dynamic var lastMessage: String = "" {
        didSet {
            let count = report.count
            if count > LIMIT {

                let dropFirst = count - LIMIT
                let text = report.dropFirst(dropFirst)

                report = text.description
            }

            report.append(lastMessage)
        }
    }

    private var report = ""
    private let LIMIT = 1000
}

func reportGeoEvent(_ text: String, _ type: GeologLevel, _ localTime: LocalTime) {

    let newline = "\r\n" + "--" + "\r\n"
    let message = "[\(localTime.date)] [\(localTime.time)]\r\n> \(text)" + newline

    geoReport.lastMessage = message
}

let geoReport = LocationServicesReport()

// MARK: - Logger

// log.turned = .off
// dmlog.turned = .off
// geolog.turned = .off

log.output = .consoleapp
dmlog.output = .consoleapp
// geolog.output = .consoleapp

geolog.format = .textonly
geolog.output = .custom

geolog.customActionOnMessage = reportGeoEvent(_:_:_:)

dmlog.time = true
log.time = true

log.message("The app's start point...", .info)

let globals = AppGlobals()

// MARK: - Run the app

// Determine the app run purpose
let appPurpose: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

// Initialize the app object from the purpose
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appPurpose))
