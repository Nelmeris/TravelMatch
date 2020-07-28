//
//  ProfilePresenter.swift
//  Profile
//
//  Created by Artem Kufaev on 27.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentProfileData()
    func presentMenuItems()
    func menuItemDidSelect(_ indexPath: IndexPath)
}

class ProfilePresenter {
    
    weak var controller: ProfileDisplayLogic?
    var coordinator: ProfileRoutingLogic?
    var profileService: ProfileService?
    
    lazy var menuSections = [
        ProfileMenuSection(title: "Аккаунт",
                           items: [
                           ProfileMenuItem(title: "Личная информация",
                                           type: .link(onSelect: {
                                            
                                           })),

                           ProfileMenuItem(title: "Мои предложения",
                                           type: .link(onSelect: {
                                               
                                           })),

                           ProfileMenuItem(title: "Сообщения",
                                           type: .link(onSelect: {
                                               
                                           })),

                           ProfileMenuItem(title: "Избранное",
                                           type: .link(onSelect: {
                                               
                                           }))
        ]),
        
        ProfileMenuSection(title: "Активность",
                           items: [
                           ProfileMenuItem(title: "Мои бронирования",
                                           type: .link(onSelect: {
                                            
                                           })),

                           ProfileMenuItem(title: "Реквизиты",
                                           type: .link(onSelect: {
                                               
                                           })),

                           ProfileMenuItem(title: "Я местный",
                                           type: .link(onSelect: {
                                               
                                           })),

                           ProfileMenuItem(title: "Заявки на бронирование",
                                           type: .link(onSelect: {
                                               
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
                                           type: .link(onSelect: {
                                            
                                           }))
        ])
    ]
    
}

extension ProfilePresenter: ProfilePresentationLogic {
    
    func presentProfileData() {
        guard let data = profileService?.getProfileData() else { return }
        controller?.displayProfileData(data)
    }
    
    func presentMenuItems() {
        controller?.displayMenuItems(menuSections)
    }
    
    func menuItemDidSelect(_ indexPath: IndexPath) {
        let item = menuSections[indexPath.section].items[indexPath.row]
        switch item.type {
        case .link(let onSelect):
            onSelect()
        default: break
        }
    }
    
}
