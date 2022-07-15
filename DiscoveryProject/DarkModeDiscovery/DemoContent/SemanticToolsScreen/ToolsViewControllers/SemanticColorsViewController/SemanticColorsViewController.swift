//
//  SemanticColorsViewController.swift
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

class SemanticColorsViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Interface Builder connections

    /// Section button for the screen in the bottom tab bar.
    @IBOutlet weak var tabButton: UITabBarItem!

    /// Table view for the list of colors.
    @IBOutlet weak var tableView: UITableView!

    // MARK: - The life cyrcle group of methods

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset.bottom = UIScreen.main.bounds.height / 3

        // Dark Mode setup

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
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

extension SemanticColorsViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource protocol

    /// Calculates the total cells of the list of semantic colors.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SemanticColorsViewList.allCases.count
    }

    /// Creates a cell with a specific color of the list of semantic colors.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SemanticColorTableCell",
                                                       for: indexPath) as? SemanticColorCell,
              let item = SemanticColorsViewList(rawValue: indexPath.row)
        else { return UITableViewCell() }

        cell.colorName = item.description
        cell.colorRepresented = item.color

        return cell
    }
}
