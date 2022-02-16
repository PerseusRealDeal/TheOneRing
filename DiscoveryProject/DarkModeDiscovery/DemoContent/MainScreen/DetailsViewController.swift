//
//  DetailsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 13.02.2022.
//

import UIKit

class DetailsViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var memberName    : UILabel!
    @IBOutlet weak var memberIcon    : UIImageView!
    
    @IBOutlet weak var memberFullName: UILabel!
    @IBOutlet weak var memberAge     : UILabel!
    
    @IBOutlet weak var memberBirth   : UITextView!
    @IBOutlet weak var memberRace    : UILabel!
    
    @IBOutlet weak var closeButton   : UIButton!
    @IBOutlet weak var bottomImage   : UIImageView!
    
    @IBAction func closeButtonAction(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Data to show details
    
    var data: Member?
    {
        didSet
        {
            guard let member = data else { return }
            
            memberIcon.image = UIImage(named: member.iconName)
            memberName.text = member.name
            
            memberFullName.text = member.fullName
            memberAge.text = member.age
            memberBirth.text = member.birth.isEmpty ? "Not known" : member.birth
            memberRace.text = member.race.rawValue
        }
    }
    
    // MARK: - The life cyrcle group of methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        closeButton.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        closeButton.layer.cornerRadius = 8
        closeButton.clipsToBounds = true
        
        bottomImage.image = UIImage(named: "Rivendell")
        
        memberIcon.layer.cornerRadius = 45
        memberIcon.clipsToBounds = true
    }
}
