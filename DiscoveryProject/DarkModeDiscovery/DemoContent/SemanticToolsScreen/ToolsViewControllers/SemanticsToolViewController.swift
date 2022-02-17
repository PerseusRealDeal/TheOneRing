//
//  SemanticsToolViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
//

import UIKit

class SemanticsToolViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var tabButton: UITabBarItem!
    
    // MARK: - The life cyrcle group of methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure()
    {
        view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        tabButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black],
                                         for: .selected)
        tabButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray],
                                         for: .normal)
    }
}
