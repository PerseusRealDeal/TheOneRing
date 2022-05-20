//
//  MemberTableViewCell.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//


import UIKit
import PerseusDarkMode

/// Represents a table view cell for a fellowship member.
class MemberTableViewCell: UITableViewCell
{
    // MARK: - Interface Builder connections
    
    /// Border view for a table view cell.
    @IBOutlet weak var memberIconBorder: UIView!
    
    /// Image for a fellowship member.
    @IBOutlet weak var memberIcon      : UIImageView!
    
    /// Title for a member name.
    @IBOutlet weak var memberName      : UILabel!
    
    /// Title for a member race.
    @IBOutlet weak var memberRace      : UILabel!
    
    // MARK: - Data to show by using the cell
    
    /// Details about a fellowship member.
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
        configure()
        
        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }
    
    // MARK: - Appearance matter methods
    
    /// Configures the table view cell.
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
    
    /// Updates the appearance of the table view cell.
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
