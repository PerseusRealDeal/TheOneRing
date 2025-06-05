//
//  ColorTableViewCell.swift, ColorTableViewCell.xib
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
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
        didSet { makeUp() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    @objc private func makeUp() {
        guard let colorSelected = colorRepresented else { return }

        colorNameLabel.textColor = .customColorLabel
        colorHexTextField.textColor = .customColorLabel
        colorRGBATextField.textColor = .customColorLabel

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
