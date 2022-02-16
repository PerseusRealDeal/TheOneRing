//
//  SemanticsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.02.2022.
//

import UIKit

class SemanticsViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeButtonAction(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - The life cyrcle group of methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        closeButton.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        closeButton.layer.cornerRadius = 8
        closeButton.clipsToBounds = true
    }
}
