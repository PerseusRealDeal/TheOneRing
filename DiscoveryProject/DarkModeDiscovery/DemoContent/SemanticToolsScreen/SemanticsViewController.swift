//
//  SemanticsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
//
//  Copyright © 2022 Mikhail Zhigulin. All rights reserved.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class SemanticsViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeButtonAction(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var optionsPanel: DarkModePanel!
    
    // MARK: - Closure for Dark Mode usr choice changed event
    
    var userChoiceChangedClosure: ((_ selected: DarkModeOption) -> Void)?
    
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
        closeButton.backgroundColor = ._customSecondaryBackground
        
        optionsPanel.backgroundColor = ._customViewSelected
    }
    
    private func configure()
    {
        setTappedAroundHandlerUp()
        
        closeButton.layer.cornerRadius = 5
        closeButton.clipsToBounds = true
        
        // Dark Mode panel
        
        optionsPanel.segmentedControlValueChangedClosure =
            { option in changeDarkModeManually(option)
                
                // Call to change the value of the other instance of Dark Mode panel
                self.userChoiceChangedClosure?(option)
            }
        
        optionsPanel.segmentedControlValue = AppearanceService.DarkModeUserChoice
        optionsPanel.backgroundColor = .clear
    }
}

extension UIViewController
{
    func setTappedAroundHandlerUp()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() { view.endEditing(true) }
}
