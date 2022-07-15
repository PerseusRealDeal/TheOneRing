//
//  HelperFunctionsLocal.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import UIKit

/// Registers settings bundle with Dark Mode option.
func registerSettingsBundle() {
    // Easy way to register just only one option
    UserDefaults.standard.register(defaults: [DARK_MODE_SETTINGS_KEY: 0])
}

extension UserDefaults {
    /// Checks the key's value existance.
    /// - Parameter key: The key for checking.
    /// - Returns: TRUE key exists, FALSE not.
    func valueExists(forKey key: String) -> Bool { object(forKey: key) != nil }
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

extension UIColor {
    /// Returns red, green, and blue from 0 to 255, and alpha from 0.0 to 1.0.
    ///
    /// ```swift
    /// let rgba = UIColor.red.RGBA255
    /// print("red: \(rgba.red), green: \(rgba.green), blue: \(rgba.blue), alpha: \(rgba.alpha)")
    /// ```
    var RGBA255: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red*255, green*255, blue*255, alpha)
    }
}

/// Creates UIColor instance using RGBA values of color required in format: 235, 235, 245, 0.6 or 235, 235, 245.
/// - Parameters:
///   - red: From 0 to 255.
///   - green: From 0 to 255.
///   - blue: From 0 to 255.
///   - alpha: From 0 to 1.0.
/// - Returns: The instance of UIColor.
func rgba255(_ red: CGFloat,
             _ green: CGFloat,
             _ blue: CGFloat,
             _ alpha: CGFloat = 1.0) -> UIColor {
    UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}

/// Converts color represented with RGBA string to color represented with HEX string.
/// - Parameter input: RGBA values of color in string. Should be in format: 235, 235, 245, 0.6 or  235, 235, 245.
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
        replacingOccurrences(of: substring,
                             with: replacement,
                             options: NSString.CompareOptions.literal,
                             range: nil)
    }

    /// Removes white spaces.
    /// - Returns: String without whitespaces.
    func removeWhitespace() -> String {
        replace(substring: " ", replacement: "")
    }
}
