//
//  SystemColorsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class SystemColorsViewController: UIViewController
{
    @IBOutlet weak var tabButton: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - The life cyrcle group of methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Make the View sensitive to Dark Mode
        
        AppearanceService.register(observer: self, selector: #selector(makeUp))
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
                                                       for: indexPath) as? ColorTableViewCell,
              let item = SystemColorsViewList(rawValue: indexPath.row)
        else { return UITableViewCell() }
        
        cell.colorName = item.description
        cell.colorRepresented = item.color
        
        return cell
    }
}
