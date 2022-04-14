//
//  ColorConverterViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 01.04.2022.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class ConverterViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var tabButton: UITabBarItem!
    
    @IBOutlet weak var RGBAInput: UITextField!
    @IBOutlet weak var HEXOutput: UITextField!
    
    @IBOutlet weak var HEXtoRGBA_Back: UILabel!
    
    @IBOutlet weak var convertButton: UIButton!
    
    @IBAction func convertTapped(_ sender: UIButton)
    {
        guard let RGBA = RGBAInput.text, let HEX = convert_RGBA_to_HEX(RGBA) else { return }
        
        HEXOutput.text = HEX
        HEXtoRGBA_Back.text = convert_HEX_to_RGBA(HEX)
    }
    
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
        convertButton.backgroundColor = ._customSecondaryBackground
        
        tabButton.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor._customTabBarItemSelected
            ],
            for: .selected)
    }
    
    private func configure()
    {
        convertButton.layer.cornerRadius = 8
        convertButton.layer.masksToBounds = true
    }
}
