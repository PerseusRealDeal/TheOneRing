//
//  TestingAppDelegate.swift
//  DarkModeDiscoveryTests
//
//  Created by Mikhail Zhigulin on 09.02.2022.
//
//  Copyright © 2022 Mikhail Zhigulin. All rights reserved.
//

import XCTest

// MARK: - The Testing Application Delegate

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        print("<< Launching with testing app delegate")
        print("<< \(type(of: self)) " + #function)
        
        return true
    }
}
