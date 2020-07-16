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
    let aboutText: String
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
            // swiftlint:disable:next line_length
            aboutText: "Я выросла в Будапеште и с детства путешествовала пешком по городу и в окрестностях, родители брали меня всегда с собой, чтобы показать мне всю красоту места, где я живу. Помощь туристам для меня больше, чем просто рутина, я занимаюсь этим уже много лет. Я одна из первых, кто начал помогать людям с организацией нестандартных впечатлений. Мне очень нравится делиться радостью открытия скрытых сокровищ города с посетителями со всего мира.",
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
                    iconURL: Bundle.main.url(forResource: "languages", withExtension: "png")!,
                    title: "Иностранные языки"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "travel", withExtension: "png")!,
                    title: "Путешествия"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "cinema", withExtension: "png")!,
                    title: "Кино"
                ),
                LocalInterest(
                    iconURL: Bundle.main.url(forResource: "books", withExtension: "png")!,
                    title: "Книги"
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
            // swiftlint:disable:next line_length
            aboutText: "Я выросла в Будапеште и с детства путешествовала пешком по городу и в окрестностях, родители брали меня всегда с собой, чтобы показать мне всю красоту места, где я живу. Помощь туристам для меня больше, чем просто рутина, я занимаюсь этим уже много лет. Я одна из первых, кто начал помогать людям с организацией нестандартных впечатлений. Мне очень нравится делиться радостью открытия скрытых сокровищ города с посетителями со всего мира.",
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
            // swiftlint:disable:next line_length
            aboutText: "Я выросла в Будапеште и с детства путешествовала пешком по городу и в окрестностях, родители брали меня всегда с собой, чтобы показать мне всю красоту места, где я живу. Помощь туристам для меня больше, чем просто рутина, я занимаюсь этим уже много лет. Я одна из первых, кто начал помогать людям с организацией нестандартных впечатлений. Мне очень нравится делиться радостью открытия скрытых сокровищ города с посетителями со всего мира.",
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
            // swiftlint:disable:next line_length
            aboutText: "Я выросла в Будапеште и с детства путешествовала пешком по городу и в окрестностях, родители брали меня всегда с собой, чтобы показать мне всю красоту места, где я живу. Помощь туристам для меня больше, чем просто рутина, я занимаюсь этим уже много лет. Я одна из первых, кто начал помогать людям с организацией нестандартных впечатлений. Мне очень нравится делиться радостью открытия скрытых сокровищ города с посетителями со всего мира.",
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
            // swiftlint:disable:next line_length
            aboutText: "Я выросла в Будапеште и с детства путешествовала пешком по городу и в окрестностях, родители брали меня всегда с собой, чтобы показать мне всю красоту места, где я живу. Помощь туристам для меня больше, чем просто рутина, я занимаюсь этим уже много лет. Я одна из первых, кто начал помогать людям с организацией нестандартных впечатлений. Мне очень нравится делиться радостью открытия скрытых сокровищ города с посетителями со всего мира.",
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
            // swiftlint:disable:next line_length
            aboutText: "Я выросла в Будапеште и с детства путешествовала пешком по городу и в окрестностях, родители брали меня всегда с собой, чтобы показать мне всю красоту места, где я живу. Помощь туристам для меня больше, чем просто рутина, я занимаюсь этим уже много лет. Я одна из первых, кто начал помогать людям с организацией нестандартных впечатлений. Мне очень нравится делиться радостью открытия скрытых сокровищ города с посетителями со всего мира.",
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
            // swiftlint:disable:next line_length
            aboutText: "Я выросла в Будапеште и с детства путешествовала пешком по городу и в окрестностях, родители брали меня всегда с собой, чтобы показать мне всю красоту места, где я живу. Помощь туристам для меня больше, чем просто рутина, я занимаюсь этим уже много лет. Я одна из первых, кто начал помогать людям с организацией нестандартных впечатлений. Мне очень нравится делиться радостью открытия скрытых сокровищ города с посетителями со всего мира.",
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
            // swiftlint:disable:next line_length
            aboutText: "Я выросла в Будапеште и с детства путешествовала пешком по городу и в окрестностях, родители брали меня всегда с собой, чтобы показать мне всю красоту места, где я живу. Помощь туристам для меня больше, чем просто рутина, я занимаюсь этим уже много лет. Я одна из первых, кто начал помогать людям с организацией нестандартных впечатлений. Мне очень нравится делиться радостью открытия скрытых сокровищ города с посетителями со всего мира.",
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
