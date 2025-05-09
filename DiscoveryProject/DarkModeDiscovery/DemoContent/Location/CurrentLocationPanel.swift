//
//  CurrentLocationPanel.swift, CurrentLocationPanel.xib
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7533 (02.01.2025).
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit

import ConsolePerseusLogger
import PerseusDarkMode
import PerseusGeoKit

class CurrentLocationPanel: UIView {

    private let theDarknessTrigger = DarkModeObserver()

    private lazy var locationViewController = { () -> LocationViewController in

        let storyboard =
            UIStoryboard(name: String(describing: LocationViewController.self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as? LocationViewController

        // Do default setup; don't set any parameter causing loadView up, breaks unit tests
        return screen ?? LocationViewController()
    }()

    // MARK: - Outlets

    @IBOutlet private weak var contentView: UIView!

    @IBOutlet private weak var buttonOpenMap: UIButton!
    @IBOutlet private weak var buttonRefreshStatus: UIButton!
    @IBOutlet private weak var buttonCurrentLocation: UIButton!

    @IBOutlet private weak var labelPermissionValue: UILabel!
    @IBOutlet private weak var labelGeoCoupleValue: UILabel!

    // MARK: - Actions

    @IBAction func actionOpenMap(_ sender: UIButton) {
        guard let vc = self.parentViewController() else { return }
        vc.present(self.locationViewController, animated: true, completion: nil)
    }

    @IBAction func buttonRefreshStatusTapped(_ sender: UIButton) {
        labelPermissionValue.text = "\(GeoAgent.currentStatus)".capitalized
        LocationDealer.requestPermission(self.parentViewController())
    }

    @IBAction func buttonRefreshCurrentTapped(_ sender: UIButton) {
        LocationDealer.requestCurrent(self.parentViewController())
    }

    // MARK: - Start

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

    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)

        addSubview(contentView)

        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(
                equalTo: widthAnchor,
                constant: .zero
            ),
            contentView.heightAnchor.constraint(
                equalTo: heightAnchor,
                constant: .zero
            )
        ])

        // Connect to Geo coordinator
        AppGlobals.geoCoordinator.locationView = self

        // Connect to Dark Mode explicitly
        theDarknessTrigger.action = { _ in self.makeUp() }
    }

    private func configure() {
        buttonRefreshStatus.layer.cornerRadius = 8
        buttonRefreshStatus.layer.masksToBounds = true
        buttonCurrentLocation.layer.cornerRadius = 8
        buttonCurrentLocation.layer.masksToBounds = true
        buttonOpenMap.layer.cornerRadius = 8
        buttonOpenMap.layer.masksToBounds = true
    }

    // MARK: - Contract

    public func reloadData() {
        reload()
    }
}

// MARK: - Implementation

extension CurrentLocationPanel {

    private func reload() {
        labelPermissionValue.text = "\(GeoAgent.currentStatus)".capitalized
        labelGeoCoupleValue.text = CURRENT_GEO_POINT
    }

    @objc private func makeUp() {
        buttonRefreshStatus.backgroundColor = .customSecondaryBackground
        buttonCurrentLocation.backgroundColor = .customSecondaryBackground
        buttonOpenMap.backgroundColor = .customSecondaryBackground
        labelPermissionValue.textColor = .customLabel
        labelGeoCoupleValue.textColor = .customLabel
    }
}
