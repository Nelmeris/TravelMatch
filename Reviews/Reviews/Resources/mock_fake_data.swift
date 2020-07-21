//
//  mock_fake_data.swift
//  Reviews
//
//  Created by Igor on 20.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import UIKit

public class MockFakeDataReviews {
    public static let data = MockFakeDataReviews()
    
    private let ownerNames = ["Alexandru","Courtney","Janko"]
    private let ownerImages = ["alexandru","courtney","janko"]
    private let descriptions = ["Откройте для себя прекрасную столицу Венгрии и исследуйте достопримечательности Будапешта с местным гидом! Общий обзор венгерской истории, культуры, искусства, традиций, гастрономии.","В каждом месте я покажу вам лучшие места для фото и поделюсь идеями, как создавать или снимать лучшие story в Instagram. Это будет лучшее впечатление!","Вы можете спросить все, что вы когда-либо хотели о Венгрии. И даже больше! Пусть это будет спорная политика, ее бурное прошлое или неопределенное будущее, экономика, наше личное мнение, идеи для изменения и т. д."]
    
    public func getReviews(count: Int) -> [Review] {
        var array: [Review] = []
        
        let counter: Int = count / ownerNames.count
        let remainder: Int = count % ownerNames.count
        
        for _ in 0..<counter {
            for i in 0..<ownerNames.count {
                let date = Date()
                let review = Review(id: i,
                                    offerID: i,
                                    ownerName: ownerNames[i],
                                    ownerImage: UIImage(named: ownerImages[i],
                                                        in: Bundle(for: MockFakeDataReviews.self),
                                                        compatibleWith: nil)!,
                                    date: date.randomDate(),
                                    description: descriptions[i])
                array.append(review)
            }
        }
        
        for i in 0..<remainder {
            let date = Date()
            let review = Review(id: i,
                                offerID: i,
                                ownerName: ownerNames[i],
                                ownerImage: UIImage(named: ownerImages[i],
                                                    in: Bundle(for: MockFakeDataReviews.self),
                                                    compatibleWith: nil)!,
                                date: date.randomDate(),
                                description: descriptions[i])
            array.append(review)
        }
        array.shuffle()
        return array
    }
    
    private init() {
    }
}

public struct Review {
    let id: Int
    let offerID: Int
    let ownerName: String
    let ownerImage: UIImage
    let date: Date
    let description: String
    
    init (id: Int, offerID: Int, ownerName: String, ownerImage: UIImage, date: Date, description: String) {
        self.id = id
        self.offerID = offerID
        self.ownerName = ownerName
        self.ownerImage = ownerImage
        self.date = date
        self.description = description
    }
}
