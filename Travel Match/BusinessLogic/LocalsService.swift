//
//  LocalsService.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 06.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Locals

struct LocalEntity: Local {
    let imageURL: URL
    let name: String
    let interests: [Interest]
    let languages: [Language]
    let activities: [Activity]
    let price: Double
    let priceDescriptor: String
}

struct LocalInterest: Interest {
    let iconURL: URL
    let title: String
}

struct LocalLanguage: Language {
    let title: String
    let level: Int
}

struct LocalActivity: Activity {
    let title: String
}

final class FakeLocalsService: LocalsService {
    
    private let data: [LocalEntity] = [
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l1", withExtension: "png")!,
            name: "Залан Шекей",
            interests: [
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "music", withExtension: "png")!,
                    title: "Музыка"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "sport", withExtension: "png")!,
                    title: "Спорт"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "travel", withExtension: "png")!,
                    title: "История"
                )
            ],
            languages: [
                LocalLanguage(title: "Русский", level: 80)
            ],
            activities: [
                LocalActivity(title: "Помощь в переводе")
            ],
            price: 600,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l2", withExtension: "png")!,
            name: "Эмилия Рацне",
            interests: [
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "music", withExtension: "png")!,
                    title: "Музыка"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "sport", withExtension: "png")!,
                    title: "Спорт"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "travel", withExtension: "png")!,
                    title: "История"
                )
            ],
            languages: [
                LocalLanguage(title: "Русский", level: 80)
            ],
            activities: [
                LocalActivity(title: "Помощь в переводе")
            ],
            price: 400,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l3", withExtension: "png")!,
            name: "Габор Богнар",
            interests: [
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "music", withExtension: "png")!,
                    title: "Музыка"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "sport", withExtension: "png")!,
                    title: "Спорт"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "travel", withExtension: "png")!,
                    title: "История"
                )
            ],
            languages: [
                LocalLanguage(title: "Русский", level: 80)
            ],
            activities: [
                LocalActivity(title: "Помощь в переводе")
            ],
            price: 400,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l4", withExtension: "png")!,
            name: "Ласло Силадь",
            interests: [
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "music", withExtension: "png")!,
                    title: "Музыка"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "sport", withExtension: "png")!,
                    title: "Спорт"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "travel", withExtension: "png")!,
                    title: "История"
                )
            ],
            languages: [
                LocalLanguage(title: "Русский", level: 80)
            ],
            activities: [
                LocalActivity(title: "Помощь в переводе")
            ],
            price: 0,
            priceDescriptor: ""
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l5", withExtension: "png")!,
            name: "Ханна Секерешне",
            interests: [
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "music", withExtension: "png")!,
                    title: "Музыка"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "sport", withExtension: "png")!,
                    title: "Спорт"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "travel", withExtension: "png")!,
                    title: "История"
                )
            ],
            languages: [
                LocalLanguage(title: "Русский", level: 80)
            ],
            activities: [
                LocalActivity(title: "Помощь в переводе")
            ],
            price: 600,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l6", withExtension: "png")!,
            name: "Нора Добошне",
            interests: [
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "music", withExtension: "png")!,
                    title: "Музыка"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "sport", withExtension: "png")!,
                    title: "Спорт"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "travel", withExtension: "png")!,
                    title: "История"
                )
            ],
            languages: [
                LocalLanguage(title: "Русский", level: 80)
            ],
            activities: [
                LocalActivity(title: "Помощь в переводе")
            ],
            price: 400,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l7", withExtension: "png")!,
            name: "Фридьеш Хегедюш",
            interests: [
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "music", withExtension: "png")!,
                    title: "Музыка"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "sport", withExtension: "png")!,
                    title: "Спорт"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "travel", withExtension: "png")!,
                    title: "История"
                )
            ],
            languages: [
                LocalLanguage(title: "Русский", level: 80)
            ],
            activities: [
                LocalActivity(title: "Помощь в переводе")
            ],
            price: 0,
            priceDescriptor: ""
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l8", withExtension: "png")!,
            name: "Андор Барна",
            interests: [
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "music", withExtension: "png")!,
                    title: "Музыка"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "sport", withExtension: "png")!,
                    title: "Спорт"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "travel", withExtension: "png")!,
                    title: "История"
                )
            ],
            languages: [
                LocalLanguage(title: "Русский", level: 80)
            ],
            activities: [
                LocalActivity(title: "Помощь в переводе")
            ],
            price: 0,
            priceDescriptor: ""
        )
    ]
    
    func search(
        request: SearchRequest?,
        completion: @escaping LocalsSearchCompletion
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(self.data))
        }
    }
    
}
