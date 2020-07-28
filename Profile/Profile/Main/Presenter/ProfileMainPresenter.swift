//
//  ProfileMainPresenter.swift
//  Profile
//
//  Created by Artem Kufaev on 27.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

protocol ProfileMainPresentationLogic {
    func presentProfileData()
    func presentMenuItems()
}

class ProfileMainPresenter {
    
    weak var controller: ProfileMainDisplayLogic?
    
}

extension ProfileMainPresenter: ProfileMainPresentationLogic {
    
    func presentProfileData() {
        let image = Bundle.main.url(forResource: "profileImage", withExtension: "png")
        let name = "Константин Коронов"
        let phoneNumber = "+7 922 328 93 34"
        let data = ProfileData(imageUrl: image, name: name, phoneNumber: phoneNumber)
        controller?.displayProfileData(data)
    }
    
    func presentMenuItems() {
        let items: [ProfileMenuSection] = [
            ProfileMenuSection(title: "Аккаунт",
                               items: [
                ProfileMenuItem(title: "Личная информация",
                                getController: { () -> UIViewController in
                                    let controller = UIViewController()
                                    controller.view.backgroundColor = .white
                                    return controller
                }),
                ProfileMenuItem(title: "Реквизиты",
                                getController: { () -> UIViewController in
                                let controller = UIViewController()
                                controller.view.backgroundColor = .white
                                return controller
                }),
                ProfileMenuItem(title: "Сообщения",
                                getController: { () -> UIViewController in
                                let controller = UIViewController()
                                controller.view.backgroundColor = .white
                                return controller
                }),
                ProfileMenuItem(title: "Избранное",
                                getController: { () -> UIViewController in
                                let controller = UIViewController()
                                controller.view.backgroundColor = .white
                                return controller
                })
            ]),
            ProfileMenuSection(title: "Активность",
                               items: [
                ProfileMenuItem(title: "Мои бронирования",
                                getController: { () -> UIViewController in
                                let controller = UIViewController()
                                controller.view.backgroundColor = .white
                                return controller
                }),
                ProfileMenuItem(title: "Мои предложения",
                                getController: { () -> UIViewController in
                                let controller = UIViewController()
                                controller.view.backgroundColor = .white
                                return controller
                }),
                ProfileMenuItem(title: "Я местный",
                                getController: { () -> UIViewController in
                                let controller = UIViewController()
                                controller.view.backgroundColor = .white
                                return controller
                }),
                ProfileMenuItem(title: "Заявки на бронирование",
                                getController: { () -> UIViewController in
                                let controller = UIViewController()
                                controller.view.backgroundColor = .white
                                return controller
                })
            ]),
            ProfileMenuSection(title: "Поддержка",
                               items: [
                ProfileMenuItem(title: "Чат с поддержкой",
                                getController: { () -> UIViewController in
                                let controller = UIViewController()
                                controller.view.backgroundColor = .white
                                return controller
                })
            ])
        ]
        controller?.displayMenuItems(items)
    }
    
}
