//
//  Member.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 12.02.2022.
//
//  Copyright © 2022 Mikhail Zhigulin. All rights reserved.
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
