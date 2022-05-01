//
//  SystemColorsViewList.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 06.04.2022.
//
//  Copyright © 2022 Mikhail Zhigulin. All rights reserved.
//

import UIKit
import AdaptedSystemUI

enum SystemColorsViewList: Int, CaseIterable, CustomStringConvertible
{
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
    
    var description: String
    {
        switch self
        {
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
    
    var color: UIColor
    {
        switch self
        {
        case .systemRed:
            return .systemRed_Adapted
        case .systemOrange:
            return .systemOrange_Adapted
        case .systemYellow:
            return .systemYellow_Adapted
        case .systemGreen:
            return .systemGreen_Adapted
        case .systemMint:
            return .systemMint_Adapted
        case .systemTeal:
            return .systemTeal_Adapted
        case .systemCyan:
            return .systemCyan_Adapted
        case .systemBlue:
            return .systemBlue_Adapted
        case .systemIndigo:
            return .systemIndigo_Adapted
        case .systemPurple:
            return .systemPurple_Adapted
        case .systemPink:
            return .systemPink_Adapted
        case .systemBrown:
            return .systemBrown_Adapted
            
        case .systemGray:
            return .systemGray_Adapted
        case .systemGray2:
            return .systemGray2_Adapted
        case .systemGray3:
            return .systemGray3_Adapted
        case .systemGray4:
            return .systemGray4_Adapted
        case .systemGray5:
            return .systemGray5_Adapted
        case .systemGray6:
            return .systemGray6_Adapted
        }
    }
}
