//
//  SemanticColorsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit

import ConsolePerseusLogger
import PerseusDarkMode

class SemanticColorsViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Interface Builder connections

    @IBOutlet weak var tabButton: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - The life cyrcle group of methods

    override func awakeFromNib() {
        super.awakeFromNib()

        // Dark Mode setup

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        log.message("[\(type(of: self))].\(#function)")

        tableView.register(UINib(nibName: "ColorTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "ColorTableViewCell")
        tableView.contentInset.bottom = UIScreen.main.bounds.height / 3
    }

    @objc private func makeUp() {

        // view.backgroundColor = .customPrimaryBackground
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

        tableView.reloadData()
    }
}

// MARK: - UITableView

extension SemanticColorsViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource protocol

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SemanticColorsViewList.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {

        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: "ColorTableViewCell",
                                              for: indexPath) as? ColorTableViewCell,
              let item = SemanticColorsViewList(rawValue: indexPath.row)
        else { return UITableViewCell() }

        cell.colorName = item.description
        cell.colorRepresented = item.color

        return cell
    }
}
