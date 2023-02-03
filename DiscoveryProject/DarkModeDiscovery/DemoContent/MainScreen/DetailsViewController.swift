//
//  DetailsViewController.swift, DetailsViewController.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit

/// Represents a screen for the details of a fellowship member.
class DetailsViewController: UIViewController {
    // MARK: - Interface Builder connections

    /// Button to close the view controller.
    @IBOutlet weak var closeButton: UIButton!

    /// Image for a fellowship member.
    @IBOutlet weak var memberIcon: UIImageView!

    /// Label for a member name.
    @IBOutlet weak var nameLabel: UILabel!

    /// Title for a member name.
    @IBOutlet weak var memberName: UILabel!

    /// Label for a member full name.
    @IBOutlet weak var fullNameLabel: UILabel!

    /// Title for a member full name.
    @IBOutlet weak var memberFullName: UILabel!

    /// Label for a member age.
    @IBOutlet weak var ageLabel: UILabel!

    /// Titile for a member age.
    @IBOutlet weak var memberAge: UILabel!

    /// Label for a member birth.
    @IBOutlet weak var birthLabel: UILabel!

    /// Title for a member birth.
    @IBOutlet weak var memberBirth: UITextView!

    /// Label for a member race.
    @IBOutlet weak var raceLabel: UILabel!

    /// Title for a member race.
    @IBOutlet weak var memberRace: UILabel!

    /// Dark Mode sensetive image at the screen bottom.
    @IBOutlet weak var bottomImage: DarkModeImageView!

    /// Closes the screen with return to the main screen.
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Details to display on screen

    /// Details about a fellowship member.
    var data: Member? {
        didSet {
            guard let member = data else { return }

            memberIcon.image = UIImage(named: member.iconName)
            memberName.text = member.name

            memberFullName.text = member.fullName
            memberAge.text = member.age
            memberBirth.text = member.birth.isEmpty ? "Not known" : member.birth
            memberRace.text = member.race.rawValue
        }
    }

    // MARK: - The life cyrcle group of methods

    override func viewDidLoad() {
        super.viewDidLoad()
        guard value(forKey: "storyboardIdentifier") != nil else { return }
        configure()

        // Dark Mode setup

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        if AppearanceService.isEnabled { makeUp() }
    }

    // MARK: - Appearance matter methods

    /// Configures the screen.
    private func configure() {
        closeButton.layer.cornerRadius = 5
        closeButton.clipsToBounds = true

        memberIcon.layer.cornerRadius = 45
        memberIcon.clipsToBounds = true

        // bottomImage.configure(UIImage(named: "Rivendell"), UIImage(named: "RivendellDark"))
    }

    /// Updates the appearance of the screen.
    @objc private func makeUp() {
        view.backgroundColor = .customPrimaryBackground
        closeButton.backgroundColor = .customSecondaryBackground

        nameLabel.textColor = .customLabel
        memberName.textColor = .customSecondaryLabel

        fullNameLabel.textColor = .customLabel
        memberFullName.textColor = .customSecondaryLabel

        ageLabel.textColor = .customLabel
        memberAge.textColor = .customSecondaryLabel

        birthLabel.textColor = .customLabel
        memberBirth.textColor = .customSecondaryLabel

        raceLabel.textColor = .customLabel
        memberRace.textColor = .customSecondaryLabel
    }
}
