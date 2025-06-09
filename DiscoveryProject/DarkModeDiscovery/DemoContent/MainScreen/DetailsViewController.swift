//
//  DetailsViewController.swift, DetailsViewController.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit
import PerseusDarkMode

class DetailsViewController: UIViewController {

    // MARK: - Interface Builder connections

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var memberIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var memberFullName: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var memberAge: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var memberBirth: UILabel!
    @IBOutlet weak var raceLabel: UILabel!
    @IBOutlet weak var memberRace: UILabel!
    @IBOutlet weak var bottomImage: DarkModeImageView!

    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Details to display on screen

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

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp()
    }

    // MARK: - Appearance matter methods

    private func configure() {
        closeButton.layer.cornerRadius = 5
        closeButton.clipsToBounds = true

        memberIcon.layer.cornerRadius = 40
        memberIcon.clipsToBounds = true

        // bottomImage.configure(UIImage(named: "Rivendell"), UIImage(named: "RivendellDark"))
    }

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
