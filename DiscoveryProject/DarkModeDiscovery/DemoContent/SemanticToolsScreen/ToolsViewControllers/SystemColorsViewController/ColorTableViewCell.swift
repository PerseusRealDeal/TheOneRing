//
//  ColorTableViewCell.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 06.04.2022.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class ColorTableViewCell: UITableViewCell
{
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var colorView     : UIView!
    @IBOutlet weak var colorHexLabel : UILabel!
    @IBOutlet weak var colorRGBALabel: UILabel!
    
    public var colorName             : String? { didSet { colorNameLabel?.text = colorName }}
    public var colorRepresented      : UIColor? { didSet { makeUp() }}
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        configure()
        
        // Make the View sensitive to Dark Mode
        
        AppearanceService.register(observer: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }
    
    @objc private func makeUp()
    {
        guard let colorSelected = colorRepresented else { return }
        
        colorNameLabel.textColor = .label_Adapted
        colorHexLabel.textColor = .label_Adapted
        colorRGBALabel.textColor = .label_Adapted
        
        colorView.backgroundColor = colorSelected
        
        var certainColor: UIColor
        var rgba:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
        
        if #available(iOS 13.0, *)
        {
            certainColor = colorSelected.resolvedColor(with: self.traitCollection)
        }
        else
        {
            certainColor = colorSelected
        }
        
        rgba = certainColor.RGBA255
        
        colorHexLabel.text = certainColor.hexString()
        
        colorRGBALabel.text = "RGBA: " +
            "\(Int(rgba.red)), "   +
            "\(Int(rgba.green)), " +
            "\(Int(rgba.blue)), "  +
            "\(Int(rgba.alpha))"
    }
    
    private func configure()
    {
        colorView.layer.cornerRadius = 25
        colorView.layer.masksToBounds = true
    }
}
