//
//  DynamicsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
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
        
        AppearanceService.register(observer: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }
    
    @objc private func makeUp()
    {
        view.backgroundColor = ._customPrimaryBackground
        
        tabButton.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.label_Adapted
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
        
        topImage.setUp(UIImage(named: "TheFellowship"), UIImage(named: "FrodoWithTheRing"))
        bottomImage.setUp(UIImage(named: "Rivendell"), UIImage(named: "RivendellDark"))
    }
}
