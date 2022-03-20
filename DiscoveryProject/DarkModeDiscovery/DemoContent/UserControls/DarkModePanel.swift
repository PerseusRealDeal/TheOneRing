//
//  OptionsPanel.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 15.02.2022.
//

import UIKit
import PerseusDarkMode
import AdaptedSystemUI

class DarkModePanel: UIView
{
    // MARK: - Interface Builder connections
    
    @IBOutlet private weak var contentView     : UIView!
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var status          : UILabel!
    
    // MARK: - Variables
    
    private var segmentedControlValue: DarkModeOption = .auto
    private var statusValue          : AppearanceStyle = .light
    
    // MARK: - Closure for segmented control value changed event
    
    var segmentedControlValueChangedClosure: ((_ actualValue: DarkModeOption) -> Void)?
    
    // MARK: - Dark Mode observer
    
    private let darkModeObserver = DarkModeObserver(AppearanceService.shared)
    
    // MARK: - Initiating
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        commonInit()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        commonInit()
        configure()
    }
    
    // MARK: - Setup user control
    
    private func commonInit()
    {
        AppearanceService.register(observer: self, selector: #selector(makeUp))
        
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: - Configure connected Interface Builder elements
    
    private func configure()
    {
        // Content border
        
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        // Segmented control
        
        updateSegmentedControl()
        segmentedControl?.addTarget(
            self,
            action: #selector(segmentedControlValueChanged(_:)),
            for: .valueChanged)
        
        // Dark Mode sensitive content
        
        updateStatus()
        darkModeObserver.action = { _ in self.updateStatus() }
    }
    
    @objc private func makeUp()
    {
        //backgroundColor = ._customViewSelected
        
        segmentedControl?.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor._customSegmentedOneNormalText
            ], for: .normal)
        
        segmentedControl?.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor._customSegmentedOneSelectedText
            ], for: .selected)
    }
    
    private func updateStatus()
    {
        statusValue = DarkMode.Style
        
        status?.text = statusValue.description
        status?.textColor = .label_Adapted
    }
    
    private func updateSegmentedControl()
    {
        switch segmentedControlValue
        {
        case .auto:
            segmentedControl?.selectedSegmentIndex = 0
        case .on:
            segmentedControl?.selectedSegmentIndex = 1
        case .off:
            segmentedControl?.selectedSegmentIndex = 2
        }
    }
    
    // MARK: - Segmented control value changed event
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            segmentedControlValue = .auto
        case 1:
            segmentedControlValue = .on
        case 2:
            segmentedControlValue = .off
        default:
            return
        }
        
        segmentedControlValueChangedClosure?(segmentedControlValue)
        
        // After processing changed event, do not forget to call setStatusValue(_:) method.
    }
    
    // MARK: - Setting segmented control value
    
    func setSegmentedControlValue(_ darkMode: DarkModeOption)
    {
        segmentedControlValue = darkMode
        updateSegmentedControl()
    }
    
}
