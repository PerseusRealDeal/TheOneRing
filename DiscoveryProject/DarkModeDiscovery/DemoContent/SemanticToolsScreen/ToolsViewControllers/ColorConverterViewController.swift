//
//  ColorConverterViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import UIKit
import PerseusDarkMode
import PerseusUISystemKit

/// Represents the UI instrument used for converting color from RGBA to HEX.
class ConverterViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Interface Builder connections

    /// Section button for the screen in the bottom tab bar.
    @IBOutlet weak var tabButton: UITabBarItem!

    /// Input: RGBA color
    @IBOutlet weak var RGBAInput: UITextField!

    /// Output: HEX
    @IBOutlet weak var HEXOutput: UITextField!

    /// Output: RGBA of the color converted from the result of convertion operation.
    @IBOutlet weak var HEXtoRGBA_Back: UILabel!

    /// Button to perform convertion operation.
    @IBOutlet weak var convertButton: UIButton!

    /// Convertion operantion with representing results on the screen.
    @IBAction func convertTapped(_ sender: UIButton) {
        guard let RGBA = RGBAInput.text, let HEX = convert_RGBA_to_HEX(RGBA) else { return }

        HEXOutput.text = HEX
        HEXtoRGBA_Back.text = convert_HEX_to_RGBA(HEX)
    }

    // MARK: - The life cyrcle group of methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()

        // Dark Mode setup

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }

    /// Updates the appearance of the instrument.
    @objc private func makeUp() {
        view.backgroundColor = .customPrimaryBackground
        convertButton.backgroundColor = .customSecondaryBackground

        tabButton.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.customTabBarItemSelected
            ],
            for: .selected)
    }

    /// Configures UI of the instrument.
    private func configure() {
        convertButton.layer.cornerRadius = 8
        convertButton.layer.masksToBounds = true

        RGBAInput.delegate = self
        HEXOutput.delegate = self
    }

    /// Hides keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
