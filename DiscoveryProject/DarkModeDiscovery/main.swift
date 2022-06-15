//
//  main.swift, LaunchScreen.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import UIKit
import PerseusDarkMode

/// Determine the app run purpose.
let appPurpose: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

/// Initialize the app object depending on the purpose.
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appPurpose))

/// The app delegate.
class AppDelegate: UIResponder { var window: UIWindow? }

/// Delegate behaviors.
extension AppDelegate: UIApplicationDelegate
{
    /// Gives entry instructions on starting.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
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
}
