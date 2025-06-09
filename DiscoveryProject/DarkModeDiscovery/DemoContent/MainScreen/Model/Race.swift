//
//  Race.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import Foundation

enum Race: String, Decodable {

    case hobbits
    case ainur
    case dwarves
    case elves
    case men

    var single: String {
        switch self {
        case .hobbits:
            return "hobbit"
        case .ainur:
            return "wizard"
        case .dwarves:
            return "dwarf"
        case .elves:
            return "elf"
        case .men:
            return "human"
        }
    }
}
