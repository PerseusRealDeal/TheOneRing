//
//  HelpFunctions.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © 7531 PerseusRealDeal.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit

/// Registers settings bundle with Dark Mode option.
func registerSettingsBundle() {
    // Easy way to register just only one option
    UserDefaults.standard.register(defaults: [DARK_MODE_SETTINGS_KEY: 0])
}

extension UIResponder {
    /// Finds parent UIResponder object that meets condition.
    ///
    /// It goes recursively through UIResponder hierarchy.
    ///
    /// - Parameter condition: The closure represents calculated condition as a parameter.
    /// - Returns: Parent UIResponder or nil if not found.
    func nextFirstResponder(where condition: (UIResponder) -> Bool ) -> UIResponder? {
        guard let next = next else { return nil }

        if condition(next) { return next } else {
            return next.nextFirstResponder(where: condition)
        }
    }
}

/// Converts color represented with RGBA string to color represented with HEX string.
/// - Parameter input: Should be in format: 235, 235, 245, 0.6 or  235, 235, 245.
/// - Returns: nil if input string not in format, HEX value of color in format: #D1D1D6FF.
func convert_RGBA_to_HEX(_ input: String) -> String? {
    guard input.isEmpty == false else { return nil }

    let array = input.removeWhitespace().split(separator: ",")

    guard array.count >= 3 else { return nil }

    let red = CGFloat(Int(array[0]) ?? 0)
    let green = CGFloat(Int(array[1]) ?? 0)
    let blue = CGFloat(Int(array[2]) ?? 0)
    let alpha = array.count == 4 ? CGFloat(Float(array[3]) ?? 1) : 1

    return rgba255(red, green, blue, alpha).hexString()
}

/// Converts color represented with HEX string to color represented with RGBA string.
/// - Parameter input: HEX value should be in format: #D1D1D6FF.
/// - Returns: nil if any problem to convert faced, RGBA in format: 235, 235, 245, 0.6.
func convert_HEX_to_RGBA(_ input: String) -> String? {
    guard let colorFromHEX = try? UIColor(cgColor: UIColor(rgba_throws: input).cgColor)
    else { return nil }

    return ""
        + "\(Int(colorFromHEX.RGBA255.red)), "
        + "\(Int(colorFromHEX.RGBA255.green)), "
        + "\(Int(colorFromHEX.RGBA255.blue)), "
        + "\(Double(round(100 * colorFromHEX.RGBA255.alpha) / 100))"
}

extension String {
    /// Replaces all occurrences of substring with replacement value.
    /// - Parameters:
    ///   - string: Substring to be replaced.
    ///   - replacement: String for replacing.
    /// - Returns: String with replacements.
    func replace(substring: String, replacement: String) -> String {
        return replacingOccurrences(of: substring,
                                    with: replacement,
                                    options: NSString.CompareOptions.literal,
                                    range: nil)
    }

    /// Removes white spaces.
    /// - Returns: String without whitespaces.
    func removeWhitespace() -> String {
        return replace(substring: " ", replacement: "")
    }
}
