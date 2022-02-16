//
//  MainViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 09.02.2022.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var titleTop    : UILabel!
    @IBOutlet weak var titleImage  : UIImageView!
    
    @IBOutlet weak var tableView   : UITableView!
    @IBOutlet weak var bottomImage : UIImageView!
    
    @IBOutlet weak var optionsPanel: OptionsPanel!
    
    // MARK: - The data to show on screen
    
    private lazy var members: [Member] =
        {
            guard let fileURL = Bundle.main.url(forResource: "members", withExtension: "json"),
                  let data = try? Data(contentsOf: fileURL)
            else { return [] }
            
            return (try? JSONDecoder().decode([Member].self, from: data)) ?? []
        }()
    
    // MARK: - Details View Controller instance
    
    private lazy var detailsToViewController =
        { () -> DetailsViewController in
            
            let storyboard = UIStoryboard(name  : String(describing: DetailsViewController.self),
                                          bundle: nil)
            
            let screen = storyboard.instantiateInitialViewController() as! DetailsViewController
            
            /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
            
            screen.view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            
            return screen
        }()
    
    // MARK: - Instance of the class
    
    class func storyboardInstance() -> MainViewController
    {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as! MainViewController
        
        /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
        
        screen.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        screen.view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        return screen
    }
    
    // MARK: - The life cyrcle group of methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        titleTop.text = "The Fellowship of the Ring"
        titleImage.image = UIImage(named: "TheFellowship")
        
        titleImage.layer.cornerRadius = 40
        titleImage.layer.masksToBounds = true
        
        bottomImage.image = UIImage(named: "TheRingOfPower")
        
        optionsPanel.segmentedControlValueChangedClosure = darkModeValueChanged
        optionsPanel.actionButtonClosure = { print("Tapped") }
    }
    
    // MARK: - Interacting with options panel controls
    
    func darkModeValueChanged(_ actualValue: DarkModeOption)
    {
        print("Dark Mode: " + actualValue.description)
        
        // Appearance should be calculated but for now this statements.
        
        switch actualValue
        {
        case .auto:
            optionsPanel.setStatusValue(.unspecified)
        case .on:
            optionsPanel.setStatusValue(.dark)
        case .off:
            optionsPanel.setStatusValue(.light)
        }
    }
    
    // MARK: - Table view datasource
    
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
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let index = self.tableView.indexPathForSelectedRow
        {
            self.tableView.deselectRow(at: index, animated: false)
        }
        
        detailsToViewController.data = members[indexPath.row]
        
        self.present(detailsToViewController, animated: true, completion: nil)
    }
}
