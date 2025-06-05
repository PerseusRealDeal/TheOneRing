//
//  ColorConverterViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit

import ConsolePerseusLogger
import PerseusDarkMode

class ConverterViewController: UIViewController, UITextFieldDelegate {

    private let colorDefault = "60, 60, 67, 0.3"

    // MARK: - Interface Builder connections

    @IBOutlet weak var tabButton: UITabBarItem!
    @IBOutlet weak var RGBAInput: UITextField!
    @IBOutlet weak var HEXOutput: UITextField!
    @IBOutlet weak var HEXtoRGBA_Back: UILabel!
    @IBOutlet weak var convertButton: UIButton!

    @IBOutlet weak var viewColor: UIView!

    @IBAction func convertTapped(_ sender: UIButton) {

        guard let RGBA = RGBAInput.text, let HEX = convert_RGBA_to_HEX(RGBA) else { return }

        HEXOutput.text = HEX
        HEXtoRGBA_Back.text = convert_HEX_to_RGBA(HEX)

        viewColor.backgroundColor = try? UIColor(rgba_throws: HEX)
    }

    // MARK: - The life cyrcle methods

    override func awakeFromNib() {
        super.awakeFromNib()

        // Dark Mode setup

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        log.message("[\(type(of: self))].\(#function)")

        self.configure()
    }

    @objc private func makeUp() {

        view.backgroundColor = .customColorBackground

        tabButton.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.customTabBarItemSelected
            ],
            for: .selected)

        tabButton.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.customTabBarItemNormal
            ],
            for: .normal)

        convertButton.backgroundColor = .customSecondaryBackground
    }

    private func configure() {

        RGBAInput.text = colorDefault

        let HEX = convert_RGBA_to_HEX(colorDefault) ?? ""
        viewColor.backgroundColor = try? UIColor(rgba_throws: HEX)

        convertButton.layer.cornerRadius = 8
        convertButton.layer.masksToBounds = true

        viewColor.layer.cornerRadius = 25
        viewColor.layer.masksToBounds = true

        RGBAInput.delegate = self
        HEXOutput.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
}
