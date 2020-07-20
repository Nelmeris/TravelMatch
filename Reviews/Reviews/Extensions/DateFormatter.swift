//
//  DateFormatter.swift
//  Reviews
//
//  Created by Igor on 20.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation

extension Date {
    
    func getMonthYear(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getDayMonthYear(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func randomDate() -> Date {
        let days = Int.random(in: 10000...20000)
        let interval =  Date().timeIntervalSince1970
        let intervalRange = Double(86_400 * days)
        let random = Double(arc4random_uniform(UInt32(intervalRange)) + 1)
        let newInterval = interval + (random - (intervalRange / 2.0))
        return Date(timeIntervalSince1970: newInterval)
    }
}
