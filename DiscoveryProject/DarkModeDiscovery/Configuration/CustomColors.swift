//
//  CustomColors.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import UIKit
import PerseusDarkMode

/// Represents custom colors requirements.
public protocol UICustomColorsProtocol
{
    // MARK: - Foreground colors

    /// Custom foreground color for the app's title.
    static var customTitle                   : UIColor { get }
    /// Custom foreground color for Labels.
    static var customLabel                   : UIColor { get }
    /// Custom foreground color for Secondary Labels.
    static var customSecondaryLabel          : UIColor { get }

    // MARK: - Background colors

    /// Custom background color for Primary Background.
    static var customPrimaryBackground       : UIColor { get }
    /// Custom background color for Secondary Background.
    static var customSecondaryBackground     : UIColor { get }

    // MARK: - Special ones

    /// Custom color for selected View.
    static var customViewSelected            : UIColor { get }
    /// Custom color for UITabBarItem.
    static var customTabBarItemSelected      : UIColor { get }
    /// Custom color for UISegmentedControl selected.
    static var customSegmentedOneSelectedText: UIColor { get }
    /// Custom color for UISegmentedControl normal.
    static var customSegmentedOneNormalText  : UIColor { get }
}

extension UIColor: UICustomColorsProtocol
{
    public static var customTitle               : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1) : #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }

    public static var customLabel               : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1) : #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }

    public static var customSecondaryLabel      : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }

    public static var customPrimaryBackground   : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) : #colorLiteral(red: 0.2373828888, green: 0.2660574913, blue: 0.4256682396, alpha: 1)
    }

    public static var customSecondaryBackground : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1) : #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    }

    public static var customViewSelected        : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) : #colorLiteral(red: 0.3201489481, green: 0.3111480434, blue: 0.438789345, alpha: 1)
    }

    public static var customTabBarItemSelected  : UIColor
    {
        if #available(iOS 13.0, *)
        {
            return AppearanceService.shared.Style == .light ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }

        return .black

    }

    public static var customSegmentedOneSelectedText: UIColor
    {
        if #available(iOS 13.0, *)
        {
            return AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }

        return .white
    }

    public static var customSegmentedOneNormalText  : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
