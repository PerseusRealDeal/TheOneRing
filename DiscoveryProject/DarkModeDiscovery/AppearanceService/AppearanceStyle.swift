//
//  AppearanceStyle.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
//

import Foundation

enum AppearanceStyle: Int, CustomStringConvertible
{
    case unspecified = 0
    case light = 1
    case dark = 2
    
    var description: String
    {
        switch self
        {
        case .unspecified:
            return "Auto"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
}
