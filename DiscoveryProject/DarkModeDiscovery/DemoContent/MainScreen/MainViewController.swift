//
//  MainViewController.swift, MainViewController.storyboard
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

/// Title of the app's theme.
let TITLE = "The Fellowship of the Ring"

/// Represents the main screen of the app.
class MainViewController: UIViewController {

    // MARK: - Interface Builder connections

    /// Title for the main theme of the app.
    @IBOutlet weak var titleTop: UILabel!

    /// Dark Mode sensetive image veiw at the top of the screen.
    @IBOutlet weak var titleImage: DarkModeImageView!

    /// The list of the fellowship members.
    @IBOutlet weak var tableView: UITableView!

    /// Image at the bottom of the screen.
    @IBOutlet weak var bottomImage: UIImageView!

    /// Dark Mode switcher.
    @IBOutlet weak var optionsPanel: DarkModePanel!

    /// Button to show the screen with semantic tools.
    @IBOutlet weak var actionToolsButton: UIButton!

    /// Shows the screen with semantic tools.
    @IBAction func actionToolsButtonTapped(_ sender: UIButton) {
        present(self.semanticToolsViewController, animated: true, completion: nil)
    }

    // MARK: - The data to show on screen

    /// The instance of the list of the fellowship members.
    ///
    /// The list is initialized with json data file.
    private lazy var members: [Member] = {
        guard let fileURL = Bundle.main.url(forResource: "members", withExtension: "json"),
              let data = try? Data(contentsOf: fileURL)
        else { return [] }

        return (try? JSONDecoder().decode([Member].self, from: data)) ?? []
    }()

    // MARK: - Child View Controllers

    /// The instance of the fellowship member details screen.
    private lazy var detailsViewController = { () -> DetailsViewController in

        let storyboard =
            UIStoryboard(name: String(describing: DetailsViewController.self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as? DetailsViewController

        /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
        return screen ?? DetailsViewController()
    }()

    /// The instance of the semantic tools screen.
    private lazy var semanticToolsViewController = { () -> SemanticsViewController in

        let storyboard =
            UIStoryboard(name: String(describing: SemanticsViewController.self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as? SemanticsViewController

        /// Do default setup; don't set any parameter causing loadView up, breaks unit tests
        screen?.userChoiceChangedClosure = { selected in
            self.optionsPanel.segmentedControlValue = selected
        }

        return screen ?? SemanticsViewController()
    }()

    // MARK: - Instance of the class

    /// Creates an instance of the main screen.
    class func storyboardInstance() -> MainViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as? MainViewController

        // Do default setup; don't set any parameter causing loadView up, breaks unit tests
        screen?.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        return screen ?? MainViewController()
    }

    // MARK: - The life cyrcle group of methods

    override func viewDidLoad() {
        super.viewDidLoad()
        guard value(forKey: "storyboardIdentifier") != nil else { return }

        configure()

        // Dark Mode setup
        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            AppearanceService.processTraitCollectionDidChange(previousTraitCollection)
        }
    }

    // MARK: - Appearance matter methods

    private func configure() {

        tableView.register(UINib(nibName: "MemberTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MemberTableViewCell")

        titleTop.text = TITLE

        titleImage.layer.cornerRadius = 40
        titleImage.layer.masksToBounds = true

        actionToolsButton.layer.cornerRadius = 8
        actionToolsButton.layer.masksToBounds = true

        bottomImage.image = UIImage(named: "OneRing")

        // Dark Mode panel

        optionsPanel.segmentedControlValueChangedClosure = { option in
            changeDarkModeManually(option)

            // The value of other one Dark Mode panel should also be changed accordingly
            self.semanticToolsViewController.optionsPanel?.segmentedControlValue = option
        }

        optionsPanel.segmentedControlValue = AppearanceService.DarkModeUserChoice
        optionsPanel.backgroundColor = .clear
    }

    @objc private func makeUp() {
        view.backgroundColor = .customPrimaryBackground
        titleTop.textColor = .customTitle

        actionToolsButton.setTitleColor(.labelPerseus, for: .normal)

        let choice = AppearanceService.DarkModeUserChoice

        optionsPanel.segmentedControlValue = choice
        semanticToolsViewController.optionsPanel?.segmentedControlValue = choice
    }
}

// MARK: - UITableView

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource protocol

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell",
                                                       for: indexPath) as? MemberTableViewCell
        else { return UITableViewCell() }

        cell.data = members[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate protocol

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: false)
        }

        present(detailsViewController, animated: true, completion: nil)
        detailsViewController.data = members[indexPath.row]
    }
}
