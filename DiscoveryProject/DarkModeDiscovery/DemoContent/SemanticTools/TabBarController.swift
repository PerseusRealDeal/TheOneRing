//
//  TabBarController.swift, SemanticsViewController.storyboard
//  TheOneRing
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit

import ConsolePerseusLogger
import PerseusDarkMode

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp()
    }

    @objc private func makeUp() {
        self.tabBar.barTintColor = .customColorBackground
    }
}
