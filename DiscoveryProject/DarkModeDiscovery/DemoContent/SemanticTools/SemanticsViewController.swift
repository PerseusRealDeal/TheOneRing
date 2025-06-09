//
//  SemanticsViewController.swift, SemanticsViewController.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit
import PerseusDarkMode

class SemanticsViewController: UIViewController {

    // MARK: - Interface Builder connections

    @IBOutlet weak var closeButton: UIButton!

    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var optionsPanel: DarkModePanel!

    // MARK: - Closure for Dark Mode usr choice changed event

    var userChoiceChangedClosure: ((_ selected: DarkModeOption) -> Void)?

    // MARK: - The life cyrcle group of methods

    override func viewDidLoad() {
        super.viewDidLoad()
        guard value(forKey: "storyboardIdentifier") != nil else { return }
        configure()

        // Dark Mode setup

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp()
    }

    @objc private func makeUp() {

        view.backgroundColor = .customColorBackground

        closeButton.backgroundColor = .customSecondaryBackground
        optionsPanel.backgroundColor = .customViewSelected
    }

    private func configure() {
        setTappedAroundHandlerUp()

        closeButton.layer.cornerRadius = 5
        closeButton.clipsToBounds = true

        // Dark Mode panel

        optionsPanel.segmentedControlValueChangedClosure = { option in
            DarkModeAgent.force(option)

            // Call to change the value of the other instance of Dark Mode panel
            self.userChoiceChangedClosure?(option)
        }

        optionsPanel.segmentedControlValue = DarkModeAgent.DarkModeUserChoice
        optionsPanel.backgroundColor = .clear
    }
}

extension UIViewController {

    func setTappedAroundHandlerUp() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() { view.endEditing(true) }
}
