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
    let items: [Item]

    struct Item {
        enum _Type {
            case link(onSelect: () -> ())
            case `switch`(isOn: Bool, onSwitch: (Bool) -> ())
        }
        
        let title: String
        let type: _Type
    }
}

protocol ProfileViewInput: class {
    func displayMenuItems(_ items: [ProfileMenuSection])
    func displayProfileData(_ data: ProfileData)
    func displayNotifySettings(_ notifySettings: NotifySettings)
}

class ProfileViewController: BaseViewController {
    
    // MARK: - Input
    
    var coordinator: ProfileRoutingLogic?
    var presenter: ProfileViewOutput?
    
    // MARK: - Output
    
    public var onLogoutButtonClicked: (() -> ())?
    
    // MARK: - Properties
    
    private let sectionHeaderHeight: CGFloat = 50
    private let rowHeight: CGFloat = 52.0
    
    private lazy var menuSections: [ProfileMenuSection] = { [weak self] in
        self?.presenter?.presentNotifySettings()
        var sections: [(String, [ProfileMenuSection.Item])] = [
            ("Аккаунт", [
                ("Личная информация", .link { self?.coordinator?.toPersonalInfo() }),
                ("Награды и достижения", .link { self?.coordinator?.toAchievements() }),
                ("Реквизиты", .link { self?.coordinator?.toOffers() }),
                ("Сообщения", .link { self?.coordinator?.toMessages() }),
                ("Избранное", .link { self?.coordinator?.toFavourites() })
            ].map(ProfileMenuSection.Item.init)),
            ("Активность", [
                ("Мои бронирования", .link { self?.coordinator?.toBookings() }),
                ("Мои предложения", .link { self?.coordinator?.toOffers() }),
                ("Я местный", .link { self?.coordinator?.toLocal() }),
                ("Заявки на бронирование", .link { self?.coordinator?.toBookingRequests() } )
            ].map(ProfileMenuSection.Item.init)),
            ("Уведомления", [
                ("Push-уведомления", .switch(isOn: self?.notifySettings?.isPushOn ?? false) {
                    self?.presenter?.setPushSetting(isOn: $0)
                }),
                ("Sms рассылка", .switch(isOn: self?.notifySettings?.isSmsOn ?? false) {
                    self?.presenter?.setSmsSetting(isOn: $0)
                }),
                ("E-mail рассылка", .switch(isOn: self?.notifySettings?.isEmailOn ?? false) {
                    self?.presenter?.setEmailSetting(isOn: $0)
                })
            ].map(ProfileMenuSection.Item.init)),
            ("Поддержка", [
                ("Чат с поддержкой", .link { self?.coordinator?.toSupportChat() } )
            ].map(ProfileMenuSection.Item.init))
        ]
        
        return sections.map(ProfileMenuSection.init)
    }()
    
    private var notifySettings: NotifySettings? {
        didSet {
            guard let notifySettings = notifySettings else { return }
            guard let pushCell = menuTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? ProfileMenuSwitchCell,
                let smsCell = menuTableView.cellForRow(at: IndexPath(row: 1, section: 2)) as? ProfileMenuSwitchCell,
                let emailCell = menuTableView.cellForRow(at: IndexPath(row: 2, section: 2)) as? ProfileMenuSwitchCell else { return }
            pushCell.switch.setOn(notifySettings.isPushOn, animated: true)
            smsCell.switch.setOn(notifySettings.isSmsOn, animated: true)
            emailCell.switch.setOn(notifySettings.isEmailOn, animated: true)
        }
    }
    
    // MARK: - Outlets

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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLastSeparatorLine()
        configureLogoutBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.presentProfileData()
        presenter?.presentNotifySettings()
    }
    
    override func updateViewConstraints() {
        menuTableViewHeight.constant = menuTableView.contentSize.height
        super.updateViewConstraints()
    }
    
    // MARK: - Private
    
    private func configureLogoutBtn() {
        let logoutImg = UIImage(named: "logout", in: Bundle(for: Self.self), compatibleWith: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logoutImg,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(onLogout))
    }
    
    @objc
    private func onLogout() {
        onLogoutButtonClicked?()
    }
    
    private func hideLastSeparatorLine() {
        let frame = CGRect(x: 0, y: 0, width: menuTableView.frame.size.width, height: 1)
        menuTableView.tableFooterView = UIView(frame: frame)
    }
    
}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {
    
    func displayProfileData(_ data: ProfileData) {
        profileImageView.sd_setImage(with: data.imageUrl, completed: nil)
        nameLabel.text = data.name
        phoneNumberLabel.text = data.phoneNumber
    }
    
    func displayMenuItems(_ items: [ProfileMenuSection]) {
        menuSections = items
    }
    
    func displayNotifySettings(_ notifySettings: NotifySettings) {
        self.notifySettings = notifySettings
    }
    
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: menuTableView.frame.width, height: sectionHeaderHeight)
        let header = TableSectionHeaderView(frame: frame)
        header.title = menuSections[section].title
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = menuSections[indexPath.section].items[indexPath.row]
        switch item.type {
        case .switch(let isOn, let onSwitch):
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMenuSwitchCell.reuseIdentifier,
                                                     for: indexPath) as! ProfileMenuSwitchCell
            cell.configure((title: item.title, isEnable: isOn), at: indexPath)
            cell.onSwitch = onSwitch
            return cell
        case .link:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMenuLinkCell.reuseIdentifier,
                                                     for: indexPath) as! ProfileMenuLinkCell
            cell.configure(item.title, at: indexPath)
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menuSections[indexPath.section].items[indexPath.row]
        switch item.type {
        case .link(let onSelect):
            onSelect()
            menuTableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
}
