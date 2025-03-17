//
//  LocationViewController.swift, LocationViewController.storyboard
//  TheOneRing
//
//  Created by Mikhail Zhigulin in 7533 (17.03.2025).
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var buttonClose: UIButton!

    @IBAction func actionButtonCloseTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard value(forKey: "storyboardIdentifier") != nil else { return }

        configure()
    }

    private func configure() {
        buttonClose.layer.cornerRadius = 5
        buttonClose.clipsToBounds = true
    }
}
