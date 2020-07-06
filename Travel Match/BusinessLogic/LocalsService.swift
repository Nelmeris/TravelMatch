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
    let interests: [String]
    let price: Double
    let priceDescriptor: String
}

final class FakeLocalsService: LocalsService {
    
    private let data: [LocalEntity] = [
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l1", withExtension: "png")!,
            name: "Залан Шекей",
            interests: ["Музыка", "Спорт", "История"],
            price: 600,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l2", withExtension: "png")!,
            name: "Эмилия Рацне",
            interests: ["Музыка", "Ночная жизнь"],
            price: 400,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l3", withExtension: "png")!,
            name: "Габор Богнар",
            interests: ["Музыка", "Спорт"],
            price: 400,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l4", withExtension: "png")!,
            name: "Ласло Силадь",
            interests: ["Музыка", "Спорт"],
            price: 0,
            priceDescriptor: ""
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l5", withExtension: "png")!,
            name: "Ханна Секерешне",
            interests: ["Музыка", "Спорт", "История"],
            price: 600,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l6", withExtension: "png")!,
            name: "Нора Добошне",
            interests: ["Музыка", "Ночная жизнь"],
            price: 400,
            priceDescriptor: "руб/час"
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l7", withExtension: "png")!,
            name: "Фридьеш Хегедюш",
            interests: ["Музыка", "Спорт"],
            price: 0,
            priceDescriptor: ""
        ),
        LocalEntity(
            imageURL: Bundle.main.url(forResource: "l8", withExtension: "png")!,
            name: "Андор Барна",
            interests: ["Музыка", "Спорт"],
            price: 0,
            priceDescriptor: ""
        )
    ]
    
    func search(
        request: SearchRequest?,
        completion: @escaping LocalsSearchCompletion
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(.success(self.data))
        }
    }
    
}
