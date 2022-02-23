//
//  OptionsPanel.swift
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin on 15.02.2022.
//

import UIKit

class OptionsPanel: UIView, AppearanceAdaptableElement
{
    deinit { AppearanceService.unregister(self) }
    
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
    private var statusValue          : AppearanceStyle = .light
    
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
        configure()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        commonInit()
        configure()
    }
    
    // MARK: - AppearanceAdaptableElement protocol
    
    func adoptAppearance() { makeUp() }
    
    // MARK: - Setup user control
    
    private func commonInit()
    {
        AppearanceService.register(self)
        
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
        
        // Status label
        
        updateStatus()
        
        // Action button
        
        updateActionButton()
    }
    
    private func makeUp()
    {
        backgroundColor = ._customViewSelected
        
        status.textColor = ._label
        actionButton.setTitleColor(._label, for: .normal)
        
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor._customSegmentedOneNormalText
            ], for: .normal)
        
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor._customSegmentedOneSelectedText
            ], for: .selected)
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
