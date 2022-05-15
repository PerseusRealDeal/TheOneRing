//
//  Member.swift, members.json
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 12.02.7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//


import Foundation

struct Member: Decodable
{
    let name    : String
    let fullName: String
    let age     : String
    let birth   : String
    let race    : Race
    let iconName: String
}
