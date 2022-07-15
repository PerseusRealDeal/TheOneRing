//
//  Member.swift, members.json
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import Foundation

/// Represents a member of the fellowship.
struct Member: Decodable {
    let name: String
    let fullName: String
    let age: String
    let birth: String
    let race: Race
    let iconName: String
}
