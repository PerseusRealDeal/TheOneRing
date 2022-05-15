//
//  SystemColorTableViewCell.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 06.04.7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class SystemColorCell: UITableViewCell, UITextFieldDelegate
{
    @IBOutlet weak var colorNameLabel    : UILabel!
    @IBOutlet weak var colorView         : UIView!
    @IBOutlet weak var colorHexTextField : UITextField!
    @IBOutlet weak var colorRGBATextField: UITextField!
    
    public var colorName                 : String? { didSet { colorNameLabel?.text = colorName }}
    public var colorRepresented          : UIColor?
    {
        didSet { if AppearanceService.isEnabled { makeUp() }}
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        configure()
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
        
        colorRGBATextField.text = "\(Int(rgba.red)), \(Int(rgba.green)), \(Int(rgba.blue))"
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
