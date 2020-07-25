//
//  FilterViewController.swift
//  Locals
//
//  Created by Maxim Timokhin on 20.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class FilterViewController: BaseViewController {

    
    @IBOutlet var pricePicker: PriceRangeControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pricePicker.valueFrom = 30
        pricePicker.valueTo = 170
        pricePicker.reloadData()
    }
    

}


extension FilterViewController: PriceRangeControlDataSource {
    func rangeControl(_ rangeControl: PriceRangeControl, valueForPrice price: Double) -> Int {
        return Int(sin(price * Double.pi / 180) * 100)
    }
    
    func minPrice(in rangeControl: PriceRangeControl) -> Double {
        return 30
    }
    
    func maxPrice(in rangeControl: PriceRangeControl) -> Double {
        return 170
    }
}
