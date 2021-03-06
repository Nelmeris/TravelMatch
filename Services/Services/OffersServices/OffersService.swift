//
//  OffersService.swift
//  Offers
//
//  Created by Igor on 29.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Offers

public class OffersService: Offers.OffersService {
    
    public static let data = OffersService()
    public let filterCollection = ["Cамолёт","Море","Отдых","Поезд","Дорога","Горы","Поход","Круиз","Еда","Кругосветное","Достопримечательности","Озеро","Сувениры","Замки"]
    
    private let offersImages = ["roman","cristina","yevhenii"]
    private let offersNames = ["Изучение исторического центра","Лучшие Insta фото","Все о жизни местных"]
    private let offersPrises = [900,400,400]
    private let offersDescriptions = ["Откройте для себя прекрасную столицу Венгрии и исследуйте достопримечательности Будапешта с местным гидом! Общий обзор венгерской истории, культуры, искусства, традиций, гастрономии.","В каждом месте я покажу вам лучшие места для фото и поделюсь идеями, как создавать или снимать лучшие story в Instagram. Это будет лучшее впечатление!","Вы можете спросить все, что вы когда-либо хотели о Венгрии. И даже больше! Пусть это будет спорная политика, ее бурное прошлое или неопределенное будущее, экономика, наше личное мнение, идеи для изменения и т. д."]
    
    public func getOffers(count: Int) -> [Offers.Offer] {
        var array: [Offer] = []
        
        let counter: Int = count / offersNames.count
        let remainder: Int = count % offersNames.count
        
        for _ in 0..<counter {
            for i in 0..<offersNames.count {
                let randomBool = Bool.random()
                let offer = Offer(id: i,
                                      name: offersNames[i],
                                      image: offersImages[i],
                                      price: offersPrises[i],
                                      description: offersDescriptions[i],
                                      inFavorite: randomBool)
                array.append(offer)
            }
        }
        
        for i in 0..<remainder {
            let randomBool = Bool.random()
            let offer = Offer(id: i,
                                  name: offersNames[i],
                                  image: offersImages[i],
                                  price: offersPrises[i],
                                  description: offersDescriptions[i],
                                  inFavorite: randomBool)
            array.append(offer)
        }
        array.shuffle()
        return array
    }

    private init() {
        
    }
}
