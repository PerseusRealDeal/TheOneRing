//
//  Race.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 12.02.2022.
//
//  Copyright © 2022 Mikhail Zhigulin. All rights reserved.
//

import Foundation

enum Race: String, Decodable
{
    case Hobbits
    case Ainur
    case Dwarves
    case Elves
    case Men

    var single: String
    {
        switch self
        {
        case .Hobbits:
            return "hobbit"
        case .Ainur:
            return "wizard"
        case .Dwarves:
            return "dwarf"
        case .Elves:
            return "elf"
        case .Men:
            return "human"
        }
    }
}
