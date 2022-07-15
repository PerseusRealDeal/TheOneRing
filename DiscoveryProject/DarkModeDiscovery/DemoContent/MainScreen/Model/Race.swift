//
//  Race.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import Foundation

/// Represents a set of races faced in the story of the middle-earth.
enum Race: String, Decodable {
    case Hobbits
    case Ainur
    case Dwarves
    case Elves
    case Men

    /// The one of the race.
    var single: String {
        switch self {
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
