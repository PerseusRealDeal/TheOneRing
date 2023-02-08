//
//  SemanticColorsViewList.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit

/// Represents the model of semantic colors for displaying on the screen.
enum SemanticColorsViewList: Int, CaseIterable, CustomStringConvertible {
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
    var description: String {
        switch self {
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
    var color: UIColor {
        switch self {
        case .label:
            return .labelPerseus
        case .secondaryLabel:
            return .secondaryLabelPerseus
        case .tertiaryLabel:
            return .tertiaryLabelPerseus
        case .quaternaryLabel:
            return .quaternaryLabelPerseus
        case .placeholderText:
            return .placeholderTextPerseus
        case .separator:
            return .separatorPerseus
        case .opaqueSeparator:
            return .opaqueSeparatorPerseus
        case .link:
            return .linkPerseus
        case .systemFill:
            return .systemFillPerseus
        case .secondarySystemFill:
            return .secondarySystemFillPerseus
        case .tertiarySystemFill:
            return .tertiarySystemFillPerseus
        case .quaternarySystemFill:
            return .quaternarySystemFillPerseus
        case .systemBackground:
            return .systemBackgroundPerseus
        case .secondarySystemBackground:
            return .secondarySystemBackgroundPerseus
        case .tertiarySystemBackground:
            return .tertiarySystemBackgroundPerseus
        case .systemGroupedBackground:
            return .systemGroupedBackgroundPerseus
        case .secondarySystemGroupedBackground:
            return .secondarySystemGroupedBackgroundPerseus
        case .tertiarySystemGroupedBackground:
            return .tertiarySystemGroupedBackgroundPerseus
        }
    }
}
