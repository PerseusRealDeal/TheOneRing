//
//  SystemColorsViewList.swift
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

/// Represents the model of system colors for displaying on the screen.
enum SystemColorsViewList: Int, CaseIterable, CustomStringConvertible {
    case systemRed    = 0
    case systemOrange = 1
    case systemYellow = 2
    case systemGreen  = 3
    case systemMint   = 4
    case systemTeal   = 5
    case systemCyan   = 6
    case systemBlue   = 7
    case systemIndigo = 8
    case systemPurple = 9
    case systemPink   = 10
    case systemBrown  = 11

    case systemGray   = 12
    case systemGray2  = 13
    case systemGray3  = 14
    case systemGray4  = 15
    case systemGray5  = 16
    case systemGray6  = 17

    /// Color name.
    var description: String {
        switch self {
        case .systemRed:
            return ".systemRed"
        case .systemOrange:
            return ".systemOrange"
        case .systemYellow:
            return ".systemYellow"
        case .systemGreen:
            return ".systemGreen"
        case .systemMint:
            return ".systemMint"
        case .systemTeal:
            return ".systemTeal"
        case .systemCyan:
            return ".systemCyan"
        case .systemBlue:
            return ".systemBlue"
        case .systemIndigo:
            return ".systemIndigo"
        case .systemPurple:
            return ".systemPurple"
        case .systemPink:
            return ".systemPink"
        case .systemBrown:
            return ".systemBrown"

        case .systemGray:
            return ".systemGray"
        case .systemGray2:
            return ".systemGray2"
        case .systemGray3:
            return ".systemGray3"
        case .systemGray4:
            return ".systemGray4"
        case .systemGray5:
            return ".systemGray5"
        case .systemGray6:
            return ".systemGray6"
        }
    }

    var color: UIColor {
        switch self {
        case .systemRed:
            return .perseusRed
        case .systemOrange:
            return .perseusOrange
        case .systemYellow:
            return .perseusYellow
        case .systemGreen:
            return .perseusGreen
        case .systemMint:
            return .perseusMint
        case .systemTeal:
            return .perseusTeal
        case .systemCyan:
            return .perseusCyan
        case .systemBlue:
            return .perseusBlue
        case .systemIndigo:
            return .perseusIndigo
        case .systemPurple:
            return .perseusPurple
        case .systemPink:
            return .perseusPink
        case .systemBrown:
            return .perseusBrown

        case .systemGray:
            return .perseusGray
        case .systemGray2:
            return .perseusGray2
        case .systemGray3:
            return .perseusGray3
        case .systemGray4:
            return .perseusGray4
        case .systemGray5:
            return .perseusGray5
        case .systemGray6:
            return .perseusGray6
        }
    }
}
