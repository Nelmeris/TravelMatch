//
//  ProfileMainViewController.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

struct ProfileMenuSection {
    let title: String
    let items: [ProfileMenuItem]
}

struct ProfileMenuItem {
    enum ProfileMenuItemType {
        case link(onSelect: () -> ())
        case `switch`
    }
    
    let title: String
    let type: ProfileMenuItemType
}

protocol ProfileDisplayLogic: class {
    func displayMenuItems(_ items: [ProfileMenuSection])
    func displayProfileData(_ data: ProfileData)
}

class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresentationLogic?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView! {
        didSet {
            menuTableView.dataSource = self
            menuTableView.delegate = self
        }
    }
    
    private var items: [ProfileMenuSection] = [] {
        didSet {
            menuTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.presentMenuItems()
        presenter?.presentProfileData()
    }
    
}

extension ProfileViewController: ProfileDisplayLogic {
    
    func displayProfileData(_ data: ProfileData) {
        self.profileImageView.sd_setImage(with: data.imageUrl, completed: nil)
        self.nameLabel.text = data.name
        self.phoneNumberLabel.text = data.phoneNumber
    }
    
    func displayMenuItems(_ items: [ProfileMenuSection]) {
        self.items = items
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    
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
        let item = items[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = item.title
        switch item.type {
        case .switch:
            cell.accessoryType = .none
        case .link:
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.menuItemDidSelect(indexPath)
    }
    
}
