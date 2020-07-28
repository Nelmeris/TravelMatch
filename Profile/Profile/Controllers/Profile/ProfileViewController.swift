//
//  ProfileMainViewController.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UI

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

protocol ProfileViewInput: class {
    func displayMenuItems(_ items: [ProfileMenuSection])
    func displayProfileData(_ data: ProfileData)
}

class ProfileViewController: UIViewController {
    
    var coordinator: ProfileRoutingLogic?
    var presenter: ProfileViewOutput?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView! {
        didSet {
            menuTableView.dataSource = self
            menuTableView.delegate = self
            menuTableView.register(UINib(nibName: "ProfileMenuSwitchCell",
                                         bundle: Bundle(for: Self.self)),
                                   forCellReuseIdentifier: ProfileMenuSwitchCell.reuseIdentifier)
            menuTableView.register(UINib(nibName: "ProfileMenuLinkCell",
                                         bundle: Bundle(for: Self.self)),
                                   forCellReuseIdentifier: ProfileMenuLinkCell.reuseIdentifier)
        }
    }
    
    @IBOutlet weak var menuTableViewHeight: NSLayoutConstraint!
    
    private lazy var menuSections = [
        ProfileMenuSection(title: "Аккаунт",
                           items: [
                           ProfileMenuItem(title: "Личная информация",
                                           type: .link(onSelect: { [weak self] in
                                            self?.coordinator?.toPersonalInfo()
                                           })),

                           ProfileMenuItem(title: "Мои предложения",
                                           type: .link(onSelect: { [weak self] in
                                            self?.coordinator?.toOffers()
                                           })),

                           ProfileMenuItem(title: "Сообщения",
                                           type: .link(onSelect: { [weak self] in
                                            self?.coordinator?.toMessages()
                                           })),

                           ProfileMenuItem(title: "Избранное",
                                           type: .link(onSelect: { [weak self] in
                                            self?.coordinator?.toFavourites()
                                           }))
        ]),
        
        ProfileMenuSection(title: "Активность",
                           items: [
                           ProfileMenuItem(title: "Мои бронирования",
                                           type: .link(onSelect: { [weak self] in
                                            self?.coordinator?.toBookings()
                                           })),

                           ProfileMenuItem(title: "Реквизиты",
                                           type: .link(onSelect: { [weak self] in
                                           self?.coordinator?.toRequisites()
                                           })),

                           ProfileMenuItem(title: "Я местный",
                                           type: .link(onSelect: { [weak self] in
                                           self?.coordinator?.toLocal()
                                           })),

                           ProfileMenuItem(title: "Заявки на бронирование",
                                           type: .link(onSelect: { [weak self] in
                                           self?.coordinator?.toBookingRequests()
                                           }))
        ]),
        
        ProfileMenuSection(title: "Уведомления",
                           items: [
                           ProfileMenuItem(title: "Push-уведомления",
                                           type: .switch),

                           ProfileMenuItem(title: "Sms рассылка",
                                           type: .switch),

                           ProfileMenuItem(title: "E-mail рассылка",
                                           type: .switch),
        ]),
        
        ProfileMenuSection(title: "Поддержка",
                           items: [
                           ProfileMenuItem(title: "Чат с поддержкой",
                                           type: .link(onSelect: { [weak self] in
                                            self?.coordinator?.toSupportChat()
                                           }))
        ])
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.presentProfileData()
    }
    
    override func updateViewConstraints() {
        menuTableViewHeight.constant = menuTableView.contentSize.height
        super.updateViewConstraints()
    }
    
}

extension ProfileViewController: ProfileViewInput {
    
    func displayProfileData(_ data: ProfileData) {
        self.profileImageView.sd_setImage(with: data.imageUrl, completed: nil)
        self.nameLabel.text = data.name
        self.phoneNumberLabel.text = data.phoneNumber
    }
    
    func displayMenuItems(_ items: [ProfileMenuSection]) {
        menuSections = items
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuSections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: menuTableView.frame.width, height: 50))
        let title = UILabel(frame: view.frame)
        title.font = UIFont(name: "Montserrat-Bold", size: 18)
        title.text = menuSections[section].title
        view.backgroundColor = .white
        view.addSubview(title)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = menuSections[indexPath.section].items[indexPath.row]
        switch item.type {
        case .switch:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMenuSwitchCell.reuseIdentifier, for: indexPath) as! ProfileMenuSwitchCell
            cell.configure((title: item.title, isEnable: false), at: indexPath)
            return cell
        case .link:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMenuLinkCell.reuseIdentifier, for: indexPath) as! ProfileMenuLinkCell
            cell.configure(item.title, at: indexPath)
            return cell
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menuSections[indexPath.section].items[indexPath.row]
        switch item.type {
        case .link(let onSelect):
            onSelect()
        default: break
        }
    }
    
}
