//
//  AppDelegate.swift
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
import PerseusDarkMode
import PerseusGeoKit

/// The app delegate.
class AppDelegate: UIResponder { var window: UIWindow? }

/// Delegate behaviors.
extension AppDelegate: UIApplicationDelegate {

    /// Gives entry instructions on starting.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        log.message("Launching with business matter purpose", .info)
        log.message("[\(type(of: self))].\(#function)", .info)

        // Register Settings Bundle
        registerSettingsBundle()

        // Init the app's window
        window = UIWindow(frame: UIScreen.main.bounds)

        // Give it a root view for the first screen
        window!.rootViewController = MainViewController.storyboardInstance()
        window!.makeKeyAndVisible()

        DarkModeAgent.force(DarkModeUserChoice)

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        log.message("[\(type(of: self))].\(#function)", .info)

        // Actualize Dark Mode style to Settings Bundle
        if let choice = DarkModeAgent.isDarkModeSettingsKeyChanged() {
            DarkModeAgent.force(choice)
        }
    }
}
