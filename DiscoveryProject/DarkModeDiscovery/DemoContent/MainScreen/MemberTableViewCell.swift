//
//  MemberTableViewCell.swift, MemeberTableViewCell.xib
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit
import PerseusDarkMode

class MemberTableViewCell: UITableViewCell {

    // MARK: - Interface Builder connections

    @IBOutlet weak var memberIconBorder: UIView!
    @IBOutlet weak var memberIcon: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberRace: UILabel!

    // MARK: - Data to show by using the cell

    var data: Member? {
        didSet {
            guard let member = data else { return }

            memberName.text = member.fullName
            memberRace.text = member.race.single
            memberIcon.image = UIImage(named: member.iconName)
        }
    }

    // MARK: - The life cyrcle group of methods

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()

        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp()
    }

    // MARK: - Appearance matter methods

    private func configure() {

        let selected = UIView()
        selectedBackgroundView = selected

        memberIconBorder.layer.cornerRadius = 45
        memberIconBorder.layer.masksToBounds = true

        memberIcon.layer.cornerRadius = 40
        memberIcon.layer.masksToBounds = true

        selected.layer.cornerRadius = 45
        selected.layer.masksToBounds = true
    }

    @objc private func makeUp() {

        memberIconBorder.backgroundColor = .customViewSelected

        selectedBackgroundView?.backgroundColor = .customViewSelected

        memberName.textColor = .customLabel
        memberRace.textColor = .customSecondaryLabel
    }
}
