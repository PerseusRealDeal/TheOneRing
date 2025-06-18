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
typealias dmlog = PerseusDarkMode.PerseusLogger
typealias geolog = PerseusGeoKit.PerseusLogger
// swiftlint:enable type_name

// MARK: - Log Reports

class LogReport: NSObject {

    public var text: String { report }

    @objc dynamic var lastMessage: String = "" {
        didSet {
            let count = report.count
            if count > LIMIT {
                report = report.dropFirst(count - LIMIT).description

                if let position = report.range(of: newline)?.upperBound {
                    report.removeFirst(position.utf16Offset(in: report)-2)
                }
            }

            report.append(lastMessage + newline)
        }
    }

    private var report = ""

    private let LIMIT = 1000
    private let newline = "\r\n--\r\n"
}

typealias LogLevel = ConsolePerseusLogger.PerseusLogger.Level

func report(_ text: String, _ type: LogLevel, _ localTime: LocalTime, _ owner: PIDandTID) {
    logReport.lastMessage = "[\(localTime.date)] [\(localTime.time)]\r\n> \(text)"
}

let logReport = LogReport()

// MARK: - Logger

// log.turned = .off
dmlog.turned = .off
// geolog.turned = .off

// log.output = .consoleapp
// dmlog.output = .consoleapp
// geolog.output = .consoleapp

// geolog.format = .textonly
// geolog.output = .custom

log.customActionOnMessage = report(_:_:_:_:)

var resetInfo = ""

if let path = Bundle.main.url(forResource: "CPLConfig", withExtension: "json") {
    if log.loadConfig(path), dmlog.loadConfig(path), geolog.loadConfig(path) {
        resetInfo = "Options successfully reseted!"
    } else {
        resetInfo = "Failed to reset options!"
    }
} else {
    resetInfo = "Failed to create URL!"
}

log.message(resetInfo)

// log.time = true
log.message("The app's start point...", .info)

let globals = AppGlobals()

// MARK: - Run the app

// Determine the app run purpose
let appPurpose: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

// Initialize the app object from the purpose
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appPurpose))
