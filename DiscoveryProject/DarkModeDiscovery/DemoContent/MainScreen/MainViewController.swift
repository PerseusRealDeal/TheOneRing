//
//  MainViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 09.02.2022.
//

import UIKit

class MainViewController: UIViewController, AppearanceAdaptableElement
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
        
        AppearanceService.register(self)
        
        titleTop.text = "The Fellowship of the Ring"
        titleImage.image = UIImage(named: "TheFellowship")
        
        titleImage.layer.cornerRadius = 40
        titleImage.layer.masksToBounds = true
        
        bottomImage.image = UIImage(named: "TheRingOfPower")
        
        optionsPanel.segmentedControlValueChangedClosure = userChoiceForDarkModeChanged
        optionsPanel.actionButtonClosure =
            {
                self.present(self.semanticToolsViewController,
                             animated  : true,
                             completion: nil)
            }
        
        optionsPanel.setSegmentedControlValue(DarkMode.DarkModeUserChoice)
        optionsPanel.setStatusValue(DarkMode.Style)
    }
    
    // MARK: - Dark Mode switched manually
    
    func userChoiceForDarkModeChanged(_ actualValue: DarkModeOption)
    {
        // Value should be saved
        
        DarkMode.DarkModeUserChoice = actualValue
        
        // Value should be updated on screen after
        
        optionsPanel.setStatusValue(DarkMode.Style)
        
        // Customise appearance
        
        AppearanceService.adoptToDarkMode()
    }
    
    // MARK: - AppearanceAdaptableElement protocol
    
    func adoptAppearance()
    {
        // Appearance customisation starts here
        
        print("[\(type(of: self))]" +
                " Dark Mode: \(DarkMode.DarkModeUserChoice)," +
                " System Style: \(DarkModeDecision.calculateSystemStyle())," +
                " Decision: \(DarkMode.Style)")
        
        optionsPanel.setStatusValue(DarkMode.Style)
        
        // TODO: Change appearance here
        
    }

    // MARK: - Child View Controllers
    
    private lazy var detailsViewController =
        { () -> DetailsViewController in
            
            let storyboard = UIStoryboard(name  : String(describing: DetailsViewController.self),
                                          bundle: nil)
            
            let screen = storyboard.instantiateInitialViewController() as! DetailsViewController
            
            /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
            
            screen.view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            
            return screen
        }()
    
    private lazy var semanticToolsViewController =
        { () -> SemanticsViewController in
            
            let storyboard = UIStoryboard(name  : String(describing: SemanticsViewController.self),
                                          bundle: nil)
            
            let screen = storyboard.instantiateInitialViewController() as! SemanticsViewController
            
            /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
            
            screen.view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            
            return screen
        }()
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
        
        detailsViewController.data = members[indexPath.row]
        
        self.present(detailsViewController, animated: true, completion: nil)
    }
}
