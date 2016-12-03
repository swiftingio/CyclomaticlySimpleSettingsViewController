//
//  ViewController.swift
//  SettingsViewController
//
//  Created by Maciej Piotrowski on 03/12/16.
//  Copyright © 2016 Maciej Piotrowski. All rights reserved.
//

import UIKit

fileprivate struct ViewModel {
    let name: String
    let indicator: UITableViewCellAccessoryType
    let action: () -> Void
}

class SettingsViewController: UIViewController {

    fileprivate var viewModel: [[ViewModel]] = []
    fileprivate let tableView = UITableView(frame: .zero, style: .grouped)
    fileprivate let cellIdentifier = String(describing: UITableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = .Settings
        setupTableView()
        setupConstraints()
        setupViewModel()
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
       let constraints = NSLayoutConstraint.filledInSuperview(tableView)
        NSLayoutConstraint.activate(constraints)
    }

    private func setupViewModel() {
        viewModel = [
            [ViewModel(name: .SetOption1, indicator: .disclosureIndicator,
                       action: { [unowned self] in self.push(SetOption1ViewController()) })],
            [ViewModel(name: .SetOption2, indicator: .disclosureIndicator,
                       action: { [unowned self] in self.push(SetOption2ViewController()) })],
            [ViewModel(name: .SetOption3, indicator: .disclosureIndicator,
                       action: { [unowned self] in self.push(SetOption3ViewController()) })],
            [ViewModel(name: .SetOption4, indicator: .disclosureIndicator,
                       action: { [unowned self] in self.push(SetOption4ViewController()) })],
            [ViewModel(name: .Logout, indicator: .none,
                       action: { [unowned self] in self.showLogoutPrompt() }),
             ViewModel(name: .LogoutAndResetData, indicator: .none,
                       action: { [unowned self] in self.showLogoutAndResetDataPrompt() }),
             ViewModel(name: .LogoutAndRemoveAccount, indicator: .none,
                       action: { [unowned self] in self.showLogoutAndRemoveAccountPrompt() })],
        ]

    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel[safe: section]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let section = indexPath.section
        let row = indexPath.row
        guard let model = viewModel[safe: section]?[safe: row] else { return cell }
        cell.textLabel?.text = model.name
        cell.accessoryType = model.indicator
        return cell
    }

}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        let section = indexPath.section
        let row = indexPath.row
        guard let model = viewModel[safe: section]?[safe: row] else { return }
        model.action()
    }
}

extension SettingsViewController {
    fileprivate func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    fileprivate func showLogoutPrompt() {
        showAlert(with: .Logout,
                  message: .LogoutPrompt,
                  desctructiveAction:
            UIAlertAction(title: .OK, style: .destructive, handler: nil))
    }

    fileprivate func showLogoutAndResetDataPrompt() {
        showAlert(with: .LogoutAndResetData,
                  message: .LogoutAndResetDataPrompt,
                  desctructiveAction:
            UIAlertAction(title: .OK, style: .destructive, handler: nil))
    }

    fileprivate func showLogoutAndRemoveAccountPrompt() {
        showAlert(with: .LogoutAndRemoveAccount,
                  message: .LogoutAndRemoveAccountPrompt,
                  desctructiveAction:
            UIAlertAction(title: .OK, style: .destructive, handler: nil))
    }

    fileprivate func showAlert(with title: String,
                               message: String,
                               nonDestructiveAction: UIAlertAction =
                                UIAlertAction(title: .Cancel, style: .cancel, handler: nil),
                               desctructiveAction: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(nonDestructiveAction)
        alert.addAction(desctructiveAction)
        present(alert, animated: true, completion: nil)
    }
}
