//
//  MemberTableViewCell.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 13.02.2022.
//

import UIKit
import PerseusDarkMode

class MemberTableViewCell: UITableViewCell
{
    // MARK: - Interface Builder connections
    
    @IBOutlet weak var memberIconBorder: UIView!
    @IBOutlet weak var memberIcon      : UIImageView!
    
    @IBOutlet weak var memberName      : UILabel!
    @IBOutlet weak var memberRace      : UILabel!
    
    // MARK: - Data to show by using the cell
    
    var data: Member?
    {
        didSet
        {
            guard let member = data else { return }
            
            memberName.text = member.fullName
            memberRace.text = member.race.single
            memberIcon.image = UIImage(named: member.iconName)
        }
    }
    
    // MARK: - The life cyrcle group of methods
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        AppearanceService.register(observer: self, selector: #selector(makeUp))
        configure()
        
        if AppearanceService.isEnabled { makeUp() }
    }
    
    // MARK: - Appearance matter methods
    
    private func configure()
    {
        // Create background view for selected ones
        
        let selected = UIView()
        selectedBackgroundView = selected
        
        // Make corners of the views rounded
        
        memberIconBorder.layer.cornerRadius = 45
        memberIconBorder.layer.masksToBounds = true
        
        memberIcon.layer.cornerRadius = 40
        memberIcon.layer.masksToBounds = true
        
        selected.layer.cornerRadius = 45
        selected.layer.masksToBounds = true
    }
    
    @objc private func makeUp()
    {
        // Set background color for Icon border view up
        
        memberIconBorder.backgroundColor = ._customViewSelected
        
        // Set background view for selected ones up
        
        selectedBackgroundView?.backgroundColor = ._customViewSelected
        
        // Set text colors
        
        memberName.textColor = ._customLabel
        memberRace.textColor = ._customSecondaryLabel
    }
}
