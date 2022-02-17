//
//  OptionsPanel.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 15.02.2022.
//

import UIKit

class OptionsPanel: UIView
{
    // MARK: - Interface Builder connections
    
    @IBOutlet private weak var contentView     : UIView!
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var status          : UILabel!
    @IBOutlet private weak var actionButton    : UIButton!
    
    @IBAction private func actionButtonTapped(_ sender: UIButton)
    {
        actionButtonClosure?()
    }
    
    // MARK: - Variables
    
    private var segmentedControlValue: DarkModeOption = .auto
    private var statusValue          : AppearanceStyle = .unspecified
    
    // MARK: - Closure for segmented control value changed event
    
    var segmentedControlValueChangedClosure: ((_ actualValue: DarkModeOption) -> Void)?
    
    // MARK: - Closure for action button touchUp event
    
    var actionButtonClosure: (() -> Void)?
    {
        didSet
        {
            updateActionButton()
        }
    }
    
    // MARK: - Initiating
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        commonInit()
        configureConnectedIBElements()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        commonInit()
        configureConnectedIBElements()
    }
    
    // MARK: - Setup user control
    
    private func commonInit()
    {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        backgroundColor = .clear
    }
    
    // MARK: - Configure connected Interface Builder elements
    
    private func configureConnectedIBElements()
    {
        // Content border
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        // Segmented control
        
        updateSegmentedControl()
        segmentedControl?.addTarget(
            self,
            action: #selector(segmentedControlValueChanged(_:)),
            for: .valueChanged)
        
        // Status label
        
        updateStatus()
        
        // Action button
        
        updateActionButton()
    }
    
    private func updateStatus()
    {
        status?.text = statusValue.description
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
    
    private func updateActionButton()
    {
        actionButton.isEnabled = actionButtonClosure == nil ? false : true
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
    
    // MARK: - Setting status value
    
    func setStatusValue(_ status: AppearanceStyle)
    {
        statusValue = status
        updateStatus()
    }
}
