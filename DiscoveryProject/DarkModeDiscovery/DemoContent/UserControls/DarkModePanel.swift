//
//  DarkModePanel.swift, DarkModePanel.xib
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © 7531 PerseusRealDeal.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit

class DarkModePanel: UIView {

    // MARK: - Interface Builder connections

    /// Outlet of the content view.
    @IBOutlet private weak var contentView: UIView!

    /// Outlet of the Dark Mode switcher.
    @IBOutlet private weak var segmentedControl: UISegmentedControl!

    // MARK: - Variables

    /// The value of the Dark Mode switcher.
    var segmentedControlValue: DarkModeOption = .auto { didSet { updateSegmentedControl() }}

    // MARK: - Closure for segmented control value changed event

    /// Runs any related code to Dark Mode switching.
    var segmentedControlValueChangedClosure: ((_ selected: DarkModeOption) -> Void)?

    // MARK: - Initiating

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
        configure()
    }

    // MARK: - Setup user control

    /// Constructs the user control.
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)

        addSubview(contentView)

        translatesAutoresizingMaskIntoConstraints = false

        contentView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        contentView.autoresizingMask =
            [
                UIView.AutoresizingMask.flexibleLeftMargin,
                UIView.AutoresizingMask.flexibleRightMargin,
                UIView.AutoresizingMask.flexibleTopMargin,
                UIView.AutoresizingMask.flexibleBottomMargin
            ]

        // Dark Mode setup

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }

    // MARK: - Configure connected Interface Builder elements

    /// Configurates the user control.
    private func configure() {
        // Content border

        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true

        // Segmented control

        updateSegmentedControl()
        segmentedControl?.addTarget(self,
                                    action: #selector(segmentedControlValueChanged(_:)),
                                    for: .valueChanged)
    }

    /// Updates the appearance of the user control.
    @objc private func makeUp() {
        segmentedControl?.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.customSegmentedOneNormalText
            ], for: .normal)

        segmentedControl?.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.customSegmentedOneSelectedText
            ], for: .selected)
    }

    /// Puts Dark Mode switcher in line with Dark Mode user option.
    private func updateSegmentedControl() {
        switch segmentedControlValue {
        case .auto:
            segmentedControl?.selectedSegmentIndex = 2
        case .on:
            segmentedControl?.selectedSegmentIndex = 1
        case .off:
            segmentedControl?.selectedSegmentIndex = 0
        }
    }

    // MARK: - Segmented control value changed event

    /// Puts Dark Mode user option in line with Dark Mode switcher.
    /// - Parameter sender: Related Dark Mode swithcer.
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
        case 0:
            segmentedControlValue = .off
        case 1:
            segmentedControlValue = .on
        case 2:
            segmentedControlValue = .auto
        default:
            return
        }

        segmentedControlValueChangedClosure?(segmentedControlValue)
    }
}
