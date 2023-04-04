//
//  main.swift, LaunchScreen.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © 7531 PerseusRealDeal.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit

// MARK: - Logger

PerseusLogger.level = .info

// MARK: - Run the app

/// Determine the app run purpose.
let appPurpose: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

/// Initialize the app object depending on the purpose.
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appPurpose))
