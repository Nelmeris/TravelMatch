//
//  LocalsService.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 06.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Locals

public final class FakeLocalsService: LocalsService {
    
    public init() {}
    
    private let data: [LocalEntity] = [
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l1", withExtension: "png")!,
            imageLargeURL: Bundle.main.url(forResource: "l1_orig", withExtension: "jpg")!,
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
                LocalLanguage(title: "Английский", level: 80),
                LocalLanguage(title: "Венгерский", level: 100),
                LocalLanguage(title: "Немецкий", level: 35)
            ],
            activities: [
                LocalActivity(title: "Помощь в переводе"),
                LocalActivity(title: "Местная еда и покупки"),
                LocalActivity(title: "Организация активного отдыха"),
                LocalActivity(title: "Помощь в поиски жилья"),
                LocalActivity(title: "Услуги гида")
            ],
            price: 600,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l2", withExtension: "png")!,
            imageLargeURL: Bundle.main.url(forResource: "l2_orig", withExtension: "jpg")!,
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
            imageLargeURL: Bundle.main.url(forResource: "l3_orig", withExtension: "jpg")!,
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
            imageLargeURL: Bundle.main.url(forResource: "l4_orig", withExtension: "jpg")!,
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
            imageLargeURL: Bundle.main.url(forResource: "l5_orig", withExtension: "jpg")!,
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
            imageLargeURL: Bundle.main.url(forResource: "l6_orig", withExtension: "jpg")!,
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
            imageLargeURL: Bundle.main.url(forResource: "l7_orig", withExtension: "jpg")!,
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
            imageLargeURL: Bundle.main.url(forResource: "l8_orig", withExtension: "jpg")!,
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
    
    public func search(
        request: SearchRequest?,
        completion: @escaping LocalsSearchCompletion
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(self.data))
        }
    }
    
}
