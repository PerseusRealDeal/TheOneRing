//
//  CustomColors.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 21.02.2022.
//

import UIKit

protocol UICustomColors
{
    // MARK: - Foreground colors
    ///
    /// Foreground colors for kinda label UI elements.
    ///
    static var _customTitle               : UIColor { get }
    static var _customLabel               : UIColor { get }
    static var _customSecondaryLabel      : UIColor { get }
    
    // MARK: - Background colors
    ///
    /// Background colors for views.
    ///
    static var _customPrimaryBackground   : UIColor { get }
    static var _customSecondaryBackground : UIColor { get }
    
    // MARK: - Special ones
    ///
    /// UIView selected
    ///
    static var _customViewSelected        : UIColor { get }
    ///
    /// UISegmentedControl
    ///
    static var _customSegmentedOneSelectedText: UIColor { get }
    static var _customSegmentedOneNormalText  : UIColor { get }
}

extension UIColor: UICustomColors
{
    static var _customTitle               : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1) : #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
    
    static var _customLabel               : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1) : #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
    
    static var _customSecondaryLabel      : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    
    static var _customPrimaryBackground   : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) : #colorLiteral(red: 0.2373828888, green: 0.2660574913, blue: 0.4256682396, alpha: 1)
    }
    
    static var _customSecondaryBackground : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 1, green: 0.578, blue: 0, alpha: 1) : #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    }
    
    static var _customViewSelected        : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) : #colorLiteral(red: 0.3201489481, green: 0.3111480434, blue: 0.438789345, alpha: 1)
    }
    
    static var _customSegmentedOneSelectedText: UIColor
    {
        if #available(iOS 13.0, *)
        {
            return AppearanceService.shared.Style == .light ? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        return .white
    }
    
    static var _customSegmentedOneNormalText  : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
