//
//  MainViewController.swift, MainViewController.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import UIKit
import PerseusDarkMode

let TITLE = "The Fellowship of the Ring"

class MainViewController: UIViewController {

    // MARK: - Interface Builder connections

    @IBOutlet weak var titleTop: UILabel!
    @IBOutlet weak var titleImage: DarkModeImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var optionsPanel: DarkModePanel!
    @IBOutlet weak var actionToolsButton: UIButton!

    @IBAction func actionToolsButtonTapped(_ sender: UIButton) {
        present(self.semanticToolsViewController, animated: true, completion: nil)
    }

    // MARK: - The data to show on screen

    private lazy var members: [Member] = {
        guard let fileURL = Bundle.main.url(forResource: "members", withExtension: "json"),
              let data = try? Data(contentsOf: fileURL)
        else { return [] }

        return (try? JSONDecoder().decode([Member].self, from: data)) ?? []
    }()

    // MARK: - Child View Controllers

    private lazy var detailsViewController = { () -> DetailsViewController in

        let storyboard =
            UIStoryboard(name: String(describing: DetailsViewController.self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as? DetailsViewController

        // Do default setup; don't set any parameter causing loadView up, breaks unit tests
        return screen ?? DetailsViewController()
    }()

    private lazy var semanticToolsViewController = { () -> SemanticsViewController in

        let storyboard =
            UIStoryboard(name: String(describing: SemanticsViewController.self), bundle: nil)
        let screen = storyboard.instantiateInitialViewController() as? SemanticsViewController

        // Do default setup; don't set any parameter causing loadView up, breaks unit tests
        screen?.userChoiceChangedClosure = { selected in
            self.optionsPanel.segmentedControlValue = selected
        }

        return screen ?? SemanticsViewController()
    }()

    // MARK: - Instance of the class

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
        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            DarkModeAgent.processTraitCollectionDidChange(previousTraitCollection)
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
            DarkModeAgent.force(option)

            // The value of other one Dark Mode panel should also be changed accordingly
            self.semanticToolsViewController.optionsPanel?.segmentedControlValue = option
        }

        optionsPanel.segmentedControlValue = DarkModeAgent.DarkModeUserChoice
        optionsPanel.backgroundColor = .clear
    }

    @objc private func makeUp() {
        view.backgroundColor = .customPrimaryBackground
        titleTop.textColor = .customTitle

        actionToolsButton.setTitleColor(.labelPerseus, for: .normal)

        let choice = DarkModeAgent.DarkModeUserChoice

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
