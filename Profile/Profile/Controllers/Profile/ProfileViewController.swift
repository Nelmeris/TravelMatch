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

    struct ProfileMenuItem {
        enum ProfileMenuItemType {
            case link(onSelect: () -> ())
            case `switch`(isOn: Bool, onSwitch: (Bool) -> ())
        }
        
        let title: String
        let type: ProfileMenuItemType
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
    
    private lazy var menuSections: [ProfileMenuSection] = { [weak self] in
        self?.presenter?.presentNotifySettings()
        var sections: [ProfileMenuSection] = []
        
        var accountItems: [ProfileMenuSection.ProfileMenuItem] = [
            .init(
                title: "Личная информация",
                type: .link {
                    self?.coordinator?.toPersonalInfo()
                }
            ),
            .init(
                title: "Награды и достижения",
                type: .link {
                    self?.coordinator?.toAchievements()
                }
            ),
            .init(
                title: "Реквизиты",
                type: .link {
                    self?.coordinator?.toOffers()
                }
            ),
            .init(
                title: "Сообщения",
                type: .link {
                    self?.coordinator?.toMessages()
                }
            ),
            .init(
                title: "Избранное",
                type: .link {
                    self?.coordinator?.toFavourites()
                }
            )
        ]
        
        var activityItems: [ProfileMenuSection.ProfileMenuItem] = [
            .init(
                title: "Мои бронирования",
                type: .link {
                    self?.coordinator?.toBookings()
                }
            ),
            .init(
                title: "Мои предложения",
                type: .link {
                    self?.coordinator?.toOffers()
                }
            ),
            .init(
                title: "Я местный",
                type: .link {
                    self?.coordinator?.toLocal()
                }
            ),
            .init(
                title: "Заявки на бронирование",
                type: .link {
                    self?.coordinator?.toBookingRequests()
                }
            )
        ]
        
        var notifyItems: [ProfileMenuSection.ProfileMenuItem] = [
            .init(
                title: "Push-уведомления",
                type: .switch(isOn: self?.notifySettings?.isPushOn ?? false) { isOn in
                    self?.presenter?.setPushSetting(isOn: isOn)
                }
            ),
            .init(
                title: "Sms рассылка",
                type: .switch(isOn: self?.notifySettings?.isSmsOn ?? false) { isOn in
                    self?.presenter?.setSmsSetting(isOn: isOn)
                }
            ),
            .init(
                title: "E-mail рассылка",
                type: .switch(isOn: self?.notifySettings?.isEmailOn ?? false) { isOn in
                    self?.presenter?.setEmailSetting(isOn: isOn)
                }
            )
        ]
        
        var supportItems: [ProfileMenuSection.ProfileMenuItem] = [
            .init(
                title: "Чат с поддержкой",
                type: .link {
                    self?.coordinator?.toSupportChat()
                }
            )
        ]
        
        sections.append(ProfileMenuSection(title: "Аккаунт",
                                           items: accountItems))
        
        sections.append(ProfileMenuSection(title: "Активность",
                                           items: activityItems))
        
        sections.append(ProfileMenuSection(title: "Уведомления",
                                           items: notifyItems))
        
        sections.append(ProfileMenuSection(title: "Поддержка",
                                           items: supportItems))
        
        return sections
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
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
    
}
