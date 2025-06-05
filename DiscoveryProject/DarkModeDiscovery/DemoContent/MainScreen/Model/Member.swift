//
//  Member.swift, members.json
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import Foundation

struct Member: Decodable {

    let name: String
    let fullName: String
    let age: String
    let birth: String
    let race: Race
    let iconName: String

}
