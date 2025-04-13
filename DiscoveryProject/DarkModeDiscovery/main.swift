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

// import class PerseusDarkMode.PerseusLogger
import class PerseusGeoLocationKit.PerseusLogger

// swiftlint:disable type_name
// typealias dmlog = PerseusDarkMode.PerseusLogger
typealias geolog = PerseusGeoLocationKit.PerseusLogger
// swiftlint:enable type_name

// MARK: - Logger

// log.output = .consoleapp
// dmlog.output = .consoleapp
// geolog.output = .consoleapp

geolog.turned = .off

// MARK: - Run the app

log.message("The app's start point...", .info)

let globals = AppGlobals()

/// Determine the app run purpose.
let appPurpose: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

/// Initialize the app object depending on the purpose.
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appPurpose))
