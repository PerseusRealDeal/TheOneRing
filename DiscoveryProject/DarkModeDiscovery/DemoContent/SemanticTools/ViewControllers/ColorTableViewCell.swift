//
//  ColorTableViewCell.swift, ColorTableViewCell.xib
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit
// import PerseusDarkMode

class ColorTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorHexTextField: UITextField!
    @IBOutlet weak var colorRGBATextField: UITextField!

    public var colorName: String? {
        didSet { colorNameLabel?.text = colorName }
    }

    public var colorRepresented: UIColor? {
        didSet { if DarkModeAgent.isEnabled { makeUp() } }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    @objc private func makeUp() {
        guard let colorSelected = colorRepresented else { return }

        colorNameLabel.textColor = .labelPerseus
        colorHexTextField.textColor = .labelPerseus
        colorRGBATextField.textColor = .labelPerseus

        let rgba = colorSelected.RGBA255

        colorView.backgroundColor = colorSelected
        colorHexTextField.text = colorSelected.hexString()

        colorRGBATextField.text = rgba.alpha < 1 ?
            "\(Int(rgba.red)), \(Int(rgba.green)), \(Int(rgba.blue)), \(rgba.alpha)" :
        "\(Int(rgba.red)), \(Int(rgba.green)), \(Int(rgba.blue))"
    }

    private func configure() {
        colorView.layer.cornerRadius = 25
        colorView.layer.masksToBounds = true

        colorHexTextField.delegate = self
        colorRGBATextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
