//
//  MainViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 09.02.2022.
//

import UIKit

class MainViewController: UIViewController
{
    class func storyboardInstance() -> MainViewController
    {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as! MainViewController
        
        /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
        
        screen.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        screen.view.backgroundColor = UIColor.yellow
        
        return screen
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
