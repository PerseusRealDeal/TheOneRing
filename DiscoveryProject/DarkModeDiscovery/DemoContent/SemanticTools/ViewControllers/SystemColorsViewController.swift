//
//  SystemColorsViewController.swift
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
// import PerseusDarkMode

/// Represents the screen for the list of system colors.
class SystemColorsViewController: UIViewController {

    // MARK: - Interface Builder connections

    /// Section button for the screen in the bottom tab bar.
    @IBOutlet weak var tabButton: UITabBarItem!

    /// Table view for the list of colors.
    @IBOutlet weak var tableView: UITableView!

    // MARK: - The life cyrcle group of methods

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ColorTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "ColorTableViewCell")

        tableView.contentInset.bottom = UIScreen.main.bounds.height / 3

        // Make the View sensitive to Dark Mode

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        if DarkModeAgent.isEnabled { makeUp() }
    }

    /// Updates the appearance of the screen.
    @objc private func makeUp() {
        view.backgroundColor = .customPrimaryBackground

        tabButton.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.customTabBarItemSelected
            ],
            for: .selected)

        tableView.reloadData()
    }
}

// MARK: - UITableView

extension SystemColorsViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource protocol

    /// Calculates the total cells of the list of system colors.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SystemColorsViewList.allCases.count
    }

    /// Creates a cell with a specific color of the list of system colors.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {

        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: "ColorTableViewCell",
                                              for: indexPath) as? ColorTableViewCell,
              let item = SystemColorsViewList(rawValue: indexPath.row)
        else { return UITableViewCell() }

        cell.colorName = item.description
        cell.colorRepresented = item.color

        return cell
    }
}
