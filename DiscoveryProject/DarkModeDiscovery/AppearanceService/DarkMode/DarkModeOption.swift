//
//  DarkModeOption.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
//

import Foundation

enum DarkModeOption: Int, CustomStringConvertible
{
    case auto = 0
    case on = 1
    case off = 2
    
    var description: String
    {
        switch self
        {
        case .auto:
            return "Auto"
        case .on:
            return "On"
        case .off:
            return "Off"
        }
    }
}
