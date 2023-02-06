//
//  SemanticsViewController.swift, SemanticsViewController.storyboard
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

/// Represents a host view controller for other view controllers.
///
///  - Holds close button for early iOS versions.
///  - Holds Dark Mode panel with Dark Mode switcher.
///  - Hides keyboard in a correct way.
class SemanticsViewController: UIViewController {

    // MARK: - Interface Builder connections

    /// Button to close the view controller.
    @IBOutlet weak var closeButton: UIButton!

    /// Returns to the main screen.
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /// Dark Mode switcher.
    @IBOutlet weak var optionsPanel: DarkModePanel!

    // MARK: - Closure for Dark Mode usr choice changed event

    var userChoiceChangedClosure: ((_ selected: DarkModeOption) -> Void)?

    // MARK: - The life cyrcle group of methods

    override func viewDidLoad() {
        super.viewDidLoad()
        guard value(forKey: "storyboardIdentifier") != nil else { return }
        configure()

        // Dark Mode setup

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }

    /// Updates the appearance of the screen.
    @objc private func makeUp() {
        view.backgroundColor = .customPrimaryBackground
        closeButton.backgroundColor = .customSecondaryBackground

        optionsPanel.backgroundColor = .customViewSelected
    }

    /// Configurates the screen.
    private func configure() {
        setTappedAroundHandlerUp()

        closeButton.layer.cornerRadius = 5
        closeButton.clipsToBounds = true

        // Dark Mode panel

        optionsPanel.segmentedControlValueChangedClosure = { option in
            changeDarkModeManually(option)

            // Call to change the value of the other instance of Dark Mode panel
            self.userChoiceChangedClosure?(option)
        }

        optionsPanel.segmentedControlValue = AppearanceService.DarkModeUserChoice
        optionsPanel.backgroundColor = .clear
    }
}

extension UIViewController {

    /// Adds recognizer for tap event to hide keyboard.
    func setTappedAroundHandlerUp() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Hides keyboard.
    @objc func hideKeyboard() { view.endEditing(true) }
}
