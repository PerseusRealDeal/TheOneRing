//
//  SemanticsViewController.swift, SemanticsViewController.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

/// Represents a host view controller for other view controllers.
///
///  - Holds close button for early iOS versions.
///  - Holds Dark Mode panel with Dark Mode switcher.
///  - Hides keyboard in a correct way.
class SemanticsViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    /// Button to close the view controller.
    @IBOutlet weak var closeButton: UIButton!
    
    /// Returns to the main screen.
    @IBAction func closeButtonAction(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    /// Dark Mode switcher.
    @IBOutlet weak var optionsPanel: DarkModePanel!
    
    // MARK: - Closure for Dark Mode usr choice changed event
    
    /// Used to run code to make other Dark Mode switchesr to be in line with the selected value.
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
    
    /// Updates the appearance of the screen.
    @objc private func makeUp()
    {
        view.backgroundColor = ._customPrimaryBackground
        closeButton.backgroundColor = ._customSecondaryBackground
        
        optionsPanel.backgroundColor = ._customViewSelected
    }
    
    /// Configurates the screen.
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
    /// Adds recognizer for tap event to hide keyboard.
    func setTappedAroundHandlerUp()
    {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// Hides keyboard.
    @objc func hideKeyboard() { view.endEditing(true) }
}
