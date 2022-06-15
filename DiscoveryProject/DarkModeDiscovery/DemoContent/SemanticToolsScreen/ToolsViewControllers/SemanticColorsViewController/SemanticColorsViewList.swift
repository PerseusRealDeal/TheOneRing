//
//  SemanticColorsViewList.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import UIKit
import AdaptedSystemUI

/// Represents the model of semantic colors for displaying on the screen.
enum SemanticColorsViewList: Int, CaseIterable, CustomStringConvertible
{
    // Label Colors

    case label                            = 0
    case secondaryLabel                   = 1
    case tertiaryLabel                    = 2
    case quaternaryLabel                  = 3

    // Text Colors

    case placeholderText                  = 4

    // Separator Colors

    case separator                        = 5
    case opaqueSeparator                  = 6

    // Link Color

    case link                             = 7

    // Fill Colors

    case systemFill                       = 8
    case secondarySystemFill              = 9
    case tertiarySystemFill               = 10
    case quaternarySystemFill             = 11

    // MARK: - For background content

    // Standard Content Background Colors

    case systemBackground                 = 12
    case secondarySystemBackground        = 13
    case tertiarySystemBackground         = 14

    // Grouped Content Background Colors

    case systemGroupedBackground          = 15
    case secondarySystemGroupedBackground = 16
    case tertiarySystemGroupedBackground  = 17

    /// Color name.
    var description: String
    {
        switch self
        {
        case .label:
            return ".label"
        case .secondaryLabel:
            return ".secondaryLabel"
        case .tertiaryLabel:
            return ".tertiaryLabel"
        case .quaternaryLabel:
            return ".quaternaryLabel"
        case .placeholderText:
            return ".placeholderText"
        case .separator:
            return ".separator"
        case .opaqueSeparator:
            return ".opaqueSeparator"
        case .link:
            return ".link"
        case .systemFill:
            return ".systemFill"
        case .secondarySystemFill:
            return ".secondarySystemFill"
        case .tertiarySystemFill:
            return ".tertiarySystemFill"
        case .quaternarySystemFill:
            return ".quaternarySystemFill"
        case .systemBackground:
            return ".systemBackground"
        case .secondarySystemBackground:
            return ".secondarySystemBackground"
        case .tertiarySystemBackground:
            return ".tertiarySystemBackground"
        case .systemGroupedBackground:
            return ".systemGroupedBackground"
        case .secondarySystemGroupedBackground:
            return ".secondarySystemGroupedBackground"
        case .tertiarySystemGroupedBackground:
            return ".tertiarySystemGroupedBackground"
        }
    }

    /// Color instance.
    var color: UIColor
    {
        switch self
        {
        case .label:
            return .label_Adapted
        case .secondaryLabel:
            return .secondaryLabel_Adapted
        case .tertiaryLabel:
            return .tertiaryLabel_Adapted
        case .quaternaryLabel:
            return .quaternaryLabel_Adapted
        case .placeholderText:
            return .placeholderText_Adapted
        case .separator:
            return .separator_Adapted
        case .opaqueSeparator:
            return .opaqueSeparator_Adapted
        case .link:
            return .link_Adapted
        case .systemFill:
            return .systemFill_Adapted
        case .secondarySystemFill:
            return .secondarySystemFill_Adapted
        case .tertiarySystemFill:
            return .tertiarySystemFill_Adapted
        case .quaternarySystemFill:
            return .quaternarySystemFill_Adapted
        case .systemBackground:
            return .systemBackground_Adapted
        case .secondarySystemBackground:
            return .secondarySystemBackground_Adapted
        case .tertiarySystemBackground:
            return .tertiarySystemBackground_Adapted
        case .systemGroupedBackground:
            return .systemGroupedBackground_Adapted
        case .secondarySystemGroupedBackground:
            return .secondarySystemGroupedBackground_Adapted
        case .tertiarySystemGroupedBackground:
            return .tertiarySystemGroupedBackground_Adapted
        }
    }
}
