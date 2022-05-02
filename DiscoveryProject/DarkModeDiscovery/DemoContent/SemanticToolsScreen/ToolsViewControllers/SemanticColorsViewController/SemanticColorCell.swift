//
//  SemanticColorTableViewCell.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 16.04.2022.
//
//  Copyright © 2022 Mikhail Zhigulin. All rights reserved.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class SemanticColorCell: UITableViewCell, UITextFieldDelegate
{
    @IBOutlet weak var colorNameLabel    : UILabel!
    @IBOutlet weak var colorView         : UIView!
    @IBOutlet weak var colorHexTextField : UITextField!
    @IBOutlet weak var colorRGBATextField: UITextField!
    
    public var colorName                 : String? { didSet { colorNameLabel?.text = colorName }}
    public var colorRepresented          : UIColor? { didSet { makeUp() }}
    
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
        colorHexTextField.textColor = .label_Adapted
        colorRGBATextField.textColor = .label_Adapted
        
        let rgba = colorSelected.RGBA255
        
        colorView.backgroundColor = colorSelected
        colorHexTextField.text = colorSelected.hexString()
        
        colorRGBATextField.text = rgba.alpha < 1 ?
            "\(Int(rgba.red)), \(Int(rgba.green)), \(Int(rgba.blue)), \(rgba.alpha)" :
            "\(Int(rgba.red)), \(Int(rgba.green)), \(Int(rgba.blue))"
    }
    
    private func configure()
    {
        colorView.layer.cornerRadius = 25
        colorView.layer.masksToBounds = true
        
        colorHexTextField.delegate = self
        colorRGBATextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

