//
//  mock_fake_data.swift
//  Pic
//
//  Created by Igor on 20.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import UIKit

public class MockFakeDataPic {
    public static let data = MockFakeDataPic()
    
    ///PIC data
    private let pictures = ["cristina","daniel","emma","florian","cristina","yevhenii"]
    
    public func getPictures(count: Int) -> [UIImage] {
        var array: [UIImage] = []
        
        let counter: Int = count / pictures.count
        let remainder: Int = count % pictures.count
        
        for _ in 0..<counter {
            for i in 0..<pictures.count {
                let picture = UIImage(named: pictures[i], in: Bundle(for: MockFakeDataPic.self), compatibleWith: nil)
                array.append(picture!)
            }
        }
        
        for i in 0..<remainder {
            let picture = UIImage(named: pictures[i], in: Bundle(for: MockFakeDataPic.self), compatibleWith: nil)
            array.append(picture!)
        }
        return array
    }
    private init() {
    }
}
