//
//  DarkMode.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 18.02.2022.
//

import UIKit

class DarkMode
{
    // MARK: - Dark Mode Style
    
    var Style             : AppearanceStyle
    {
        DarkModeDecision.calculateActualStyle(userChoice: DarkModeUserChoice)
    }
    
    // MARK: - Dark Mode Style saved in UserDafaults
    
    var userDefaults      : UserDefaults?
    
    var DarkModeUserChoice: DarkModeOption
    {
        get
        {
            guard let ud = userDefaults else { return DARK_MODE_USER_CHOICE_DEFAULT }
            
            // load enum int value
            
            let rawValue = ud.valueExists(forKey: DARK_MODE_USER_CHOICE_OPTION_KEY) ?
                ud.integer(forKey: DARK_MODE_USER_CHOICE_OPTION_KEY) :
                DARK_MODE_USER_CHOICE_DEFAULT.rawValue
            
            // try to cast int value to enum
            
            if let result = DarkModeOption.init(rawValue: rawValue) { return result }
            
            return DARK_MODE_USER_CHOICE_DEFAULT
        }
        set { userDefaults?.setValue(newValue.rawValue,forKey: DARK_MODE_USER_CHOICE_OPTION_KEY) }
    }
}

