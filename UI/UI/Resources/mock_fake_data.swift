//
//  mock_fake_data.swift
//  Travel Match
//
//  Created by Igor on 19.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import UIKit

public class MockFakeDataUI {
    static let data = MockFakeDataUI()
    
    ///PIC data
    private let pictures = ["cristina","daniel","emma","florian","cristina","yevhenii"]
    
    func getPictures(count: Int) -> [UIImage] {
        var array: [UIImage] = []
        
        let counter: Int = count / ownerNames.count
        let remainder: Int = count % ownerNames.count
        
        for _ in 0..<counter {
            for i in 0..<ownerNames.count {
                let picture = UIImage(named: pictures[i], in: Bundle(for: MockFakeDataUI.self), compatibleWith: nil)
                array.append(picture!)
            }
        }
        
        for i in 0..<remainder {
            let picture = UIImage(named: pictures[i], in: Bundle(for: MockFakeDataUI.self), compatibleWith: nil)
            array.append(picture!)
        }
        array.shuffle()
        return array
    }
    
    ///Review data
    private let ownerNames = ["Изучение исторического центра","Лучшие Insta фото","Все о жизни местных"]
    private let ownerImages = ["roman","cristina","yevhenii"]
    private let descriptions = ["Откройте для себя прекрасную столицу Венгрии и исследуйте достопримечательности Будапешта с местным гидом! Общий обзор венгерской истории, культуры, искусства, традиций, гастрономии.","В каждом месте я покажу вам лучшие места для фото и поделюсь идеями, как создавать или снимать лучшие story в Instagram. Это будет лучшее впечатление!","Вы можете спросить все, что вы когда-либо хотели о Венгрии. И даже больше! Пусть это будет спорная политика, ее бурное прошлое или неопределенное будущее, экономика, наше личное мнение, идеи для изменения и т. д."]
    
    func getReviews(count: Int) -> [Review] {
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
                                                        in: Bundle(for: MockFakeDataUI.self),
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
                                                    in: Bundle(for: MockFakeDataUI.self),
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
