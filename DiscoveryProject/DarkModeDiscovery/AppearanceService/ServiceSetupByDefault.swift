//
//  ServiceSetupByDefault.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 18.02.2022.
//

import UIKit

protocol AppearanceAdaptableElement
{
    func adoptAppearance()
}

class AppearanceService
{
    static var shared: DarkMode =
        {
            let instance = DarkMode()
            
            instance.userDefaults = UserDefaults.standard
            
            return instance
        }()
    
    private init() { }
}

extension UIViewController { var DarkMode: DarkMode { AppearanceService.shared } }
extension UIView { var DarkMode: DarkMode { AppearanceService.shared } }

extension AppearanceService
{
    private static var adoptableElements = Set<UIResponder>()
    
    static func adoptToDarkMode()
    {
        guard adoptableElements.isEmpty != true else { return }
        
        adoptableElements.forEach(
            { item in
                
                if let element = item as? AppearanceAdaptableElement
                {
                    element.adoptAppearance()
                }
            })
    }
    
    static func register(_ screenElement: AppearanceAdaptableElement)
    {
        guard let element = screenElement as? UIResponder else { return }
        
        adoptableElements.insert(element)
    }
    
    static func unregister(_ screenElement: AppearanceAdaptableElement)
    {
        guard let element = screenElement as? UIResponder else { return }
        
        adoptableElements.remove(element)
    }
}

class UIWindowAdoptable: UIWindow
{
    // MARK: - Dark Mode switching via system options
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
    {
        guard
            #available(iOS 13.0, *),
            let previousSystemStyle = previousTraitCollection?.userInterfaceStyle,
            previousSystemStyle.rawValue != DarkModeDecision.calculateSystemStyle().rawValue
        else { return }
    
        AppearanceService.adoptToDarkMode()
    }
}
