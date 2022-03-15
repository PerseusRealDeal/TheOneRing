//
//  DetailsViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 13.02.2022.
//

import UIKit
import PerseusDarkMode

class DetailsViewController: UIViewController
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var nameLabel     : UILabel!
    @IBOutlet weak var memberName    : UILabel!
    @IBOutlet weak var memberIcon    : UIImageView!
    
    @IBOutlet weak var fullNameLabel : UILabel!
    @IBOutlet weak var memberFullName: UILabel!
    
    @IBOutlet weak var ageLabel      : UILabel!
    @IBOutlet weak var memberAge     : UILabel!
    
    @IBOutlet weak var birthLabel    : UILabel!
    @IBOutlet weak var memberBirth   : UITextView!
    
    @IBOutlet weak var raceLabel     : UILabel!
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
        
        AppearanceService.register(observer: self, selector: #selector(makeUp))
        configure()
        
        if AppearanceService.isEnabled { makeUp() }
    }
    
    // MARK: - Appearance matter methods
    
    private func configure()
    {
        closeButton.layer.cornerRadius = 8
        closeButton.clipsToBounds = true
        
        memberIcon.layer.cornerRadius = 45
        memberIcon.clipsToBounds = true
    }
    
    @objc private func makeUp()
    {
        view.backgroundColor = ._customPrimaryBackground
        closeButton.backgroundColor = ._customSecondaryBackground
        
        nameLabel.textColor = ._customLabel
        memberName.textColor = ._customSecondaryLabel
        
        fullNameLabel.textColor = ._customLabel
        memberFullName.textColor = ._customSecondaryLabel
        
        ageLabel.textColor = ._customLabel
        memberAge.textColor = ._customSecondaryLabel
        
        birthLabel.textColor = ._customLabel
        memberBirth.textColor = ._customSecondaryLabel
        
        raceLabel.textColor = ._customLabel
        memberRace.textColor = ._customSecondaryLabel
        
        bottomImage.image = DarkMode.Style == .light ?
            UIImage(named: "Rivendell") :
            UIImage(named: "RivendellDark")
    }
}

/*
 print("[\(type(of: self))]" +
         " Dark Mode: \(DarkMode.DarkModeUserChoice)," +
         " System Style: \(DarkModeDecision.calculateSystemStyle())," +
         " Decision: \(DarkMode.Style)")
 */
