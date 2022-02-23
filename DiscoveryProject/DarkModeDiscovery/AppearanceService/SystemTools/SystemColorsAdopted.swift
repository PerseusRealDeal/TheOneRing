//
//  SystemColorsTool.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 20.02.2022.
//

import UIKit

// MARK: System colors

protocol UISystemColorsAdopted
{
    // MARK: - Default set of system colors
    
    ///
    /// System colors.
    ///
    static var _systemOrange: UIColor { get }
    static var _systemYellow: UIColor { get }
    static var _systemBrown : UIColor { get }
    
    ///
    /// System gray group.
    ///
    static var _systemGray  : UIColor { get }
    static var _systemGray2 : UIColor { get }
    
    // MARK: - Accessible set of system colors
}

extension UIColor: UISystemColorsAdopted
{
    ///
    /// System colors.
    ///
    static var _systemOrange: UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)
    }
    
    static var _systemYellow: UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1)
    }
    
    static var _systemBrown : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.6352941176, green: 0.5176470588, blue: 0.368627451, alpha: 1) : #colorLiteral(red: 0.6745098039, green: 0.5568627451, blue: 0.4078431373, alpha: 1)
    }
    
    ///
    /// System gray group.
    ///
    static var _systemGray  : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1) : #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
    }
    
    static var _systemGray2 : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6980392157, alpha: 1) : #colorLiteral(red: 0.3882352941, green: 0.3882352941, blue: 0.4, alpha: 1)
    }
}
