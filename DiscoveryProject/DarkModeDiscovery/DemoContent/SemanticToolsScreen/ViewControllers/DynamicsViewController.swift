//
//  DynamicsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit
import PerseusDarkMode

/// Represents the idea of dynamic image view with two samples.
class DynamicsViewController: UIViewController {

    // MARK: - Interface Builder connections

    /// Section button for the screen in the bottom tab bar.
    @IBOutlet weak var tabButton: UITabBarItem!

    /// The first sample of dynamic image idea.
    @IBOutlet weak var topImage: DarkModeImageView!

    /// The second sample of dynamic image idea.
    @IBOutlet weak var bottomImage: DarkModeImageView!

    // MARK: - The life cyrcle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()

        // Dark Mode setup
        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }

    @objc private func makeUp() {
        view.backgroundColor = .customPrimaryBackground

        tabButton.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.customTabBarItemSelected
            ],
            for: .selected)
    }

    private func configure() {

        topImage.layer.cornerRadius = 40
        topImage.layer.masksToBounds = true

        bottomImage.layer.cornerRadius = 40
        bottomImage.layer.masksToBounds = true
    }
}
