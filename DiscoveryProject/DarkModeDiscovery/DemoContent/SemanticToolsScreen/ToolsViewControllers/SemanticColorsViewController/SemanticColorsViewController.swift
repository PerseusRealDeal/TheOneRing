//
//  SemanticColorsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class SemanticColorsViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabButton: UITabBarItem!
    
    // MARK: - The life cyrcle group of methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.configure()
        
        // Dark Mode setup
        
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
    
    private func configure() { }
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
