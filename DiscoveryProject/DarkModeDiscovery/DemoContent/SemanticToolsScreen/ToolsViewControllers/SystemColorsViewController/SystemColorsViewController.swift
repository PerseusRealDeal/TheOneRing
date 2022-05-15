//
//  SystemColorsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class SystemColorsViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabButton: UITabBarItem!
    
    // MARK: - The life cyrcle group of methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.contentInset.bottom = UIScreen.main.bounds.height / 3
        
        // Make the View sensitive to Dark Mode
        
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

extension SystemColorsViewController: UITableViewDataSource, UITableViewDelegate
{
    // MARK: - UITableViewDataSource protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        SystemColorsViewList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SystemColorTableCell",
                                                       for: indexPath) as? SystemColorCell,
              let item = SystemColorsViewList(rawValue: indexPath.row)
        else { return UITableViewCell() }
        
        cell.colorName = item.description
        cell.colorRepresented = item.color
        
        return cell
    }
}
