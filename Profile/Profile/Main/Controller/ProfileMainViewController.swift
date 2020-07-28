//
//  ProfileMainViewController.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

struct ProfileData {
    let imageUrl: URL?
    let name: String
    let phoneNumber: String
}

struct ProfileMenuSection {
    let title: String
    let items: [ProfileMenuItem]
}

struct ProfileMenuItem {
    let title: String
    let getController: () -> UIViewController
}

protocol ProfileMainDisplayLogic: class {
    func displayMenuItems(_ items: [ProfileMenuSection])
    func displayProfileData(_ data: ProfileData)
}

class ProfileMainViewController: UIViewController {
    
    var presenter: ProfileMainPresentationLogic?
    var coordinator: ProfileMainRoutingLogic?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    private var items: [ProfileMenuSection] = [] {
        didSet {
            menuTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        presenter?.presentMenuItems()
        presenter?.presentProfileData()
    }
    
}

extension ProfileMainViewController: ProfileMainDisplayLogic {
    
    func displayProfileData(_ data: ProfileData) {
        self.profileImageView.sd_setImage(with: data.imageUrl, completed: nil)
        self.nameLabel.text = data.name
        self.phoneNumberLabel.text = data.phoneNumber
    }
    
    func displayMenuItems(_ items: [ProfileMenuSection]) {
        self.items = items
    }
    
}

extension ProfileMainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.section].items[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}

extension ProfileMainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = items[indexPath.section].items[indexPath.row].getController()
        coordinator?.toController(controller)
        menuTableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
    
}
