//
//  TestingAppDelegate.swift
//  DarkModeDiscoveryTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © 7531 PerseusRealDeal.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import XCTest
@testable import DarkModeDiscovery

// MARK: - The Testing Application Delegate

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        PerseusLogger.message("Launching with testing matter purpose", .info)
        PerseusLogger.message("[\(type(of: self))].\(#function)")

        return true
    }
}
