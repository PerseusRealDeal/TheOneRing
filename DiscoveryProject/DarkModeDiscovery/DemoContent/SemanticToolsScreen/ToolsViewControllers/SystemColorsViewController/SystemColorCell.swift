//
//  SystemColorTableViewCell.swift
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

/// Represents a table view cell for system color.
class SystemColorCell: UITableViewCell, UITextFieldDelegate {
    /// Title for a color.
    @IBOutlet weak var colorNameLabel: UILabel!

    /// Content view for color details.
    @IBOutlet weak var colorView: UIView!

    /// HEX value of color.
    @IBOutlet weak var colorHexTextField: UITextField!

    /// RGBA value of color.
    @IBOutlet weak var colorRGBATextField: UITextField!

    /// Color name.
    public var colorName: String? { didSet { colorNameLabel?.text = colorName }}

    /// Color to be represented on the screen in details.
    public var colorRepresented: UIColor? {
        didSet { if AppearanceService.isEnabled { makeUp() }}
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    /// Updates the appearance of the table view cell.
    @objc private func makeUp() {
        guard let colorSelected = colorRepresented else { return }

        colorNameLabel.textColor = .labelPerseus
        colorHexTextField.textColor = .labelPerseus
        colorRGBATextField.textColor = .labelPerseus

        let rgba = colorSelected.RGBA255

        colorView.backgroundColor = colorSelected
        colorHexTextField.text = colorSelected.hexString()

        colorRGBATextField.text = "\(Int(rgba.red)), \(Int(rgba.green)), \(Int(rgba.blue))"
    }

    /// Configures the table view cell.
    private func configure() {
        colorView.layer.cornerRadius = 25
        colorView.layer.masksToBounds = true

        colorHexTextField.delegate = self
        colorRGBATextField.delegate = self
    }

    /// Hides keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
