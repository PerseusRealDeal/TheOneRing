//
//  AppDelegate.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit

import ConsolePerseusLogger
import PerseusDarkMode
import PerseusGeoKit

class AppDelegate: UIResponder { var window: UIWindow? }

extension AppDelegate: UIApplicationDelegate {

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
        GeoCoordinator.reloadGeoComponents()

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        log.message("[\(type(of: self))].\(#function)")

        // Actualize Dark Mode style to Settings Bundle
        if let choice = DarkModeAgent.isDarkModeSettingsKeyChanged() {
            DarkModeAgent.force(choice)
        }
    }
}
