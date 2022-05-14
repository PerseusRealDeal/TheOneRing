//
//  SemanticColorsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
//
//  Copyright © 2022 Mikhail Zhigulin. All rights reserved.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class SemanticColorsViewController: UIViewController, UITextFieldDelegate
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabButton: UITabBarItem!
    
    // MARK: - The life cyrcle group of methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.contentInset.bottom = UIScreen.main.bounds.height / 3
        
        // Dark Mode setup
        
        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }
    
    @objc private func makeUp()
    {
        view.backgroundColor = ._customPrimaryBackground
        
        tabButton.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor._customTabBarItemSelected
            ],
            for: .selected)
        
        tableView.reloadData()
    }
}

// MARK: - UITableView

extension SemanticColorsViewController: UITableViewDataSource, UITableViewDelegate
{
    // MARK: - UITableViewDataSource protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        SemanticColorsViewList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SemanticColorTableCell",
                                                       for: indexPath) as? SemanticColorCell,
              let item = SemanticColorsViewList(rawValue: indexPath.row)
        else { return UITableViewCell() }
        
        cell.colorName = item.description
        cell.colorRepresented = item.color
        
        return cell
    }
}
