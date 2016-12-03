//
//  ViewController.swift
//  SettingsViewController
//
//  Created by Maciej Piotrowski on 03/12/16.
//  Copyright © 2016 Maciej Piotrowski. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    fileprivate let tableView = UITableView(frame: .zero, style: .grouped)
    fileprivate let cellIdentifier = String(describing: UITableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = .Settings
        setupTableView()
        setupConstraints()
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
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0...3:
            return 1
        case 4:
            return 3
        default:
            fatalError("Wrong number of sections")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let section = indexPath.section
        let row = indexPath.row
        switch (section, row) {
        case (0, 0):
            cell.textLabel?.text = .SetOption1
            cell.accessoryType = .disclosureIndicator
        case (1, 0):
            cell.textLabel?.text = .SetOption2
            cell.accessoryType = .disclosureIndicator
        case (2, 0):
            cell.textLabel?.text = .SetOption3
            cell.accessoryType = .disclosureIndicator
        case (3, 0):
            cell.textLabel?.text = .SetOption4
            cell.accessoryType = .disclosureIndicator
        case (4, 0):
            cell.textLabel?.text = .Logout
        case (4, 1):
            cell.textLabel?.text = .LogoutAndResetData
        case (4, 2):
            cell.textLabel?.text = .LogoutAndRemoveAccount
        default:
            fatalError("Wrong number of sections")
        }
        return cell
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        let section = indexPath.section
        let row = indexPath.row
        switch (section, row) {
        case (0, 0):
            navigationController?.pushViewController(SetOption1ViewController(), animated: true)
        case (1, 0):
            navigationController?.pushViewController(SetOption2ViewController(), animated: true)
        case (2, 0):
            navigationController?.pushViewController(SetOption3ViewController(), animated: true)
        case (3, 0):
            navigationController?.pushViewController(SetOption4ViewController(), animated: true)
        case (4, 0):
            showLogoutPrompt()
        case (4, 1):
            showLogoutAndResetDataPrompt()
        case (4, 2):
            showLogoutAndRemoveAccountPrompt()
        default:
            fatalError("Wrong number of sections")
        }
    }
}

extension SettingsViewController {
    
    fileprivate func showLogoutPrompt() {
        showAlert(with: .Logout, message: .LogoutPrompt, desctructiveAction: UIAlertAction(title: .OK, style: .destructive, handler: nil))
    }
    
    fileprivate func showLogoutAndResetDataPrompt() {
        showAlert(with: .LogoutAndResetData, message: .LogoutAndResetDataPrompt, desctructiveAction: UIAlertAction(title: .OK, style: .destructive, handler: nil))
    }
    
    fileprivate func showLogoutAndRemoveAccountPrompt() {
        showAlert(with: .LogoutAndRemoveAccount, message: .LogoutAndRemoveAccountPrompt, desctructiveAction: UIAlertAction(title: .OK, style: .destructive, handler: nil))
    }
    
    fileprivate func showAlert(with title: String,
                               message: String,
                               nonDestructiveAction: UIAlertAction = UIAlertAction(title: .Cancel, style: .cancel, handler: nil),
                               desctructiveAction: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(nonDestructiveAction)
        alert.addAction(desctructiveAction)
        present(alert, animated: true, completion: nil)
    }
}
