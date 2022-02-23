//
//  Helpers.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 21.02.2022.
//

import UIKit

extension UserDefaults
{
    func valueExists(forKey key: String) -> Bool
    {
        return object(forKey: key) != nil
    }
}

extension UIResponder
{
    func nextFirstResponder(where condition: (UIResponder) -> Bool ) -> UIResponder?
    {
        guard let next = next else { return nil }
        
        if condition(next) { return next }
        else { return next.nextFirstResponder(where: condition) }
    }
}

extension UIColor
{
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
