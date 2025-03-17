//
//  TestingAppDelegate.swift
//  DarkModeDiscoveryTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import XCTest
import ConsolePerseusLogger

@testable import TheOneRing

// MARK: - The Testing Application Delegate

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        log.message("Launching with testing matter purpose", .info)
        log.message("[\(type(of: self))].\(#function)")

        return true
    }
}
