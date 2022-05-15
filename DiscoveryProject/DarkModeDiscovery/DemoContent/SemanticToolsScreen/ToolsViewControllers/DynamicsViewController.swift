//
//  DynamicsViewController.swift
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

class DynamicsViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var topImage   : DarkModeImageView!
    @IBOutlet weak var bottomImage: DarkModeImageView!
    
    @IBOutlet weak var tabButton  : UITabBarItem!
    
    // MARK: - The life cyrcle group of methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.configure()
        
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
    }
    
    private func configure()
    {
        // Images
        
        topImage.layer.cornerRadius = 40
        topImage.layer.masksToBounds = true
        
        bottomImage.layer.cornerRadius = 40
        bottomImage.layer.masksToBounds = true
        
        topImage.configure(UIImage(named: "TheFellowship"), UIImage(named: "FrodoWithTheRing"))
        bottomImage.configure(UIImage(named: "Rivendell"), UIImage(named: "RivendellDark"))
    }
}
