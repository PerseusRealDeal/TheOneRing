//
//  AppearanceStyle.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
//

import Foundation

enum AppearanceStyle: Int, CustomStringConvertible
{
    case light = 0
    case dark = 1
    
    var description: String
    {
        switch self
        {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
}

enum SystemStyle: Int
{
    case unspecified = 0
    case light = 1
    case dark = 2
}
