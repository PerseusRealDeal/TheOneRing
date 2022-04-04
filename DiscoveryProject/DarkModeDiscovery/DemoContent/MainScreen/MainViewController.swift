//
//  MainViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 09.02.2022.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

let TITLE = "The Fellowship of the Ring"

class MainViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var titleTop         : UILabel!
    @IBOutlet weak var titleImage       : DarkModeImageView!
    
    @IBOutlet weak var tableView        : UITableView!
    @IBOutlet weak var bottomImage      : UIImageView!
    
    @IBOutlet weak var optionsPanel     : DarkModePanel!
    
    @IBOutlet weak var actionToolsButton: UIButton!
    
    @IBAction func actionToolsButtonTapped(_ sender: UIButton)
    {
        present(self.semanticToolsViewController, animated: true, completion: nil)
    }
    
    // MARK: - The data to show on screen
    
    private lazy var members: [Member] =
        {
            guard let fileURL = Bundle.main.url(forResource: "members", withExtension: "json"),
                  let data = try? Data(contentsOf: fileURL)
            else { return [] }
            
            return (try? JSONDecoder().decode([Member].self, from: data)) ?? []
        }()
    
    // MARK: - Child View Controllers
    
    private lazy var detailsViewController =
        { () -> DetailsViewController in
            
            let storyboard = UIStoryboard(name  : String(describing: DetailsViewController.self),
                                          bundle: nil)
            
            let screen = storyboard.instantiateInitialViewController() as! DetailsViewController
            
            /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
            
            return screen
        }()
    
    private lazy var semanticToolsViewController =
        { () -> SemanticsViewController in
            
            let storyboard = UIStoryboard(name  : String(describing: SemanticsViewController.self),
                                          bundle: nil)
            
            let screen = storyboard.instantiateInitialViewController() as! SemanticsViewController
            
            /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
            
            screen.userChoiceChangedClosure =
                { selected  in self.optionsPanel.setSegmentedControlValue(selected) }
            
            return screen
        }()
    
    // MARK: - Instance of the class
    
    class func storyboardInstance() -> MainViewController
    {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as! MainViewController
        
        /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
        
        screen.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        
        return screen
    }
    
    // MARK: - The life cyrcle group of methods
    
    let darkModeObserver = DarkModeObserver(AppearanceService.shared)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        AppearanceService.register(observer: self, selector: #selector(makeUp))
        configure()
    }
    
    // MARK: - Appearance matter methods
    
    private func configure()
    {
        // Static content
        
        titleTop.text = TITLE
        
        titleImage.layer.cornerRadius = 40
        titleImage.layer.masksToBounds = true
        
        actionToolsButton.layer.cornerRadius = 8
        actionToolsButton.layer.masksToBounds = true
        
        bottomImage.image = UIImage(named: "OneRing")
        
        // Dark Mode panel
        
        optionsPanel.segmentedControlValueChangedClosure =
            { selected in changeDarkMode(selected)
                
                // Change a value of other one Dark Mode panel accordingly
                self.semanticToolsViewController.optionsPanel?.setSegmentedControlValue(selected)
            }
        
        optionsPanel.setSegmentedControlValue(AppearanceService.DarkModeUserChoice)
        
        optionsPanel.backgroundColor = .clear
        
        // Images
        
        titleImage.setUp(UIImage(named: "TheFellowship"), UIImage(named: "FrodoWithTheRing"))
    }
    
    @objc private func makeUp()
    {
        view.backgroundColor = ._customPrimaryBackground
        titleTop.textColor = ._customTitle
        
        actionToolsButton.setTitleColor(.label_Adapted, for: .normal)
    }
}

// MARK: - UITableView

extension MainViewController: UITableViewDataSource, UITableViewDelegate
{
    // MARK: - UITableViewDataSource protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "MemberCell", for: indexPath) as? MemberTableViewCell
        else { return UITableViewCell() }
        
        cell.data = members[indexPath.row]
        
        return cell
    }
    
    // MARK: - UITableViewDelegate protocol
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let index = self.tableView.indexPathForSelectedRow
        {
            self.tableView.deselectRow(at: index, animated: false)
        }
        
        present(detailsViewController, animated: true, completion: nil)
        detailsViewController.data = members[indexPath.row]
    }
}

// MARK: - Experiments

extension MainViewController
{
    private func experiment()
    {
        print("[\(type(of: self))] " + #function)
        
        print("UserChoice: \(AppearanceService.DarkModeUserChoice)")
        print("System: \(AppearanceService.shared.SystemStyle)")
        print("DarkMode: \(AppearanceService.shared.Style)")
        
        titleTop.isHidden = true
        
        if #available(iOS 13.0, *),
           let view = titleTop.nextFirstResponder(where: { $0 is UIView }) as? UIView
        {
            view.backgroundColor = .label
            print(UIColor.label.rgba)
        }
    }
}

/*
 
 print("UserChoice: \(AppearanceService.shared.DarkModeUserChoice)")
 print("System: \(DarkModeDecision.calculateSystemStyle())")
 print("DarkMode: \(AppearanceService.shared.Style)")
 
 print("[\(type(of: self))] " + #function)
 
 //let _ = UIColor()
 //let _ : UIColor = .systemRed
 
 //if #available(iOS 13.0, *) { self.view.backgroundColor = ._systemBackground }
 //if #available(iOS 13.0, *) { print(UIColor.systemBackground.rgba) }
 
 */
