//
//  MemberTableViewCell.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 13.02.2022.
//

import UIKit

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
        
        // Set background color for Icon border view
        
        memberIconBorder.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        // Create and set background view for selected ones
        
        let selected = UIView()
        selected.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        selectedBackgroundView = selected
        
        // Make corners of the views rounded
        
        memberIconBorder.layer.cornerRadius = 45
        memberIconBorder.layer.masksToBounds = true
        
        memberIcon.layer.cornerRadius = 40
        memberIcon.layer.masksToBounds = true
        
        selected.layer.cornerRadius = 45
        selected.layer.masksToBounds = true
    }
}
