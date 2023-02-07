//
//  AppDelegate.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit

/// The app delegate.
class AppDelegate: UIResponder { var window: UIWindow? }

/// Delegate behaviors.
extension AppDelegate: UIApplicationDelegate {

    /// Gives entry instructions on starting.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        #if DEBUG
        print(">> Launching with business matter purpose")
        print(">> [\(type(of: self))]." + #function)
        #endif

        // Register Settings Bundle
        registerSettingsBundle()

        // Init the app's window
        window = UIWindow(frame: UIScreen.main.bounds)

        // Give it a root view for the first screen
        window!.rootViewController = MainViewController.storyboardInstance()
        window!.makeKeyAndVisible()

        // And, finally, apply a new style for all screens
        // AppearanceService.makeUp()

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        #if DEBUG
        print(">> [\(type(of: self))]." + #function)
        #endif

        // Update Dark Mode from Settings
        if let choice = isDarkModeSettingsChanged() {
            // Change Dark Mode value in Perseus Dark Mode library
            AppearanceService.DarkModeUserChoice = choice
            // Update appearance in accoring with changed Dark Mode Style
            AppearanceService.makeUp()
        }
    }
}
