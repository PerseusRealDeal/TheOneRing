//
//  DynamicsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit

import ConsolePerseusLogger
import PerseusDarkMode

class DynamicsViewController: UIViewController {

    // MARK: - Interface Builder connections

    @IBOutlet weak var tabButton: UITabBarItem!
    @IBOutlet weak var topImage: DarkModeImageView!
    @IBOutlet weak var bottomImage: DarkModeImageView!
    @IBOutlet weak var buttonPDMStyle: UIButton!
    @IBOutlet weak var buttonPDMSystemStyle: UIButton!

    @IBAction func buttonPDMStyleTapped(_ sender: UIButton) {
        log.message("1 = \(DarkModeAgent.shared.style)")
    }

    @IBAction func buttonPDMSystemStyleTapped(_ sender: UIButton) {
        let text = "2 = tapped"
        log.message(text)
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

        buttonPDMStyle.backgroundColor = .customSecondaryBackground
        buttonPDMSystemStyle.backgroundColor = .customSecondaryBackground
    }

    private func configure() {
        topImage.layer.cornerRadius = 40
        topImage.layer.masksToBounds = true

        bottomImage.layer.cornerRadius = 40
        bottomImage.layer.masksToBounds = true

        buttonPDMStyle.layer.cornerRadius = 8
        buttonPDMStyle.layer.masksToBounds = true

        buttonPDMSystemStyle.layer.cornerRadius = 8
        buttonPDMSystemStyle.layer.masksToBounds = true
    }
}
