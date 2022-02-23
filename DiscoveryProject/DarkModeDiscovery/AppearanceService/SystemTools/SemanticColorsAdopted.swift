//
//  SemanticColors.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 20.02.2022.
//

import UIKit

// MARK: Semantic colors

protocol UISemanticColorsAdopted
{
    // MARK: - Foreground colors
    ///
    /// Foreground colors for static text and related elements.
    ///
    static var _label           : UIColor { get }
    
}

extension UIColor: UISemanticColorsAdopted
{
    // MARK: - Foreground colors
    
    static var _label           : UIColor
    {
        AppearanceService.shared.Style == .light ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
    }
    
}
