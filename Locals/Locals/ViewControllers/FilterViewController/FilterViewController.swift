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

    // MARK: - Output
    var onClose: (() -> Void)?
    var onChooseLanguage: (() -> Void)?
    var onSubmit: (() -> Void)?
    
    // MARK: - Outlets
    @IBOutlet var pricePicker: PriceRangeControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pricePicker.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func submitButtonAction(_ sender: Any) {
        onSubmit?()
    }
    
    @IBAction func priceChangeAction(_ sender: Any) {
        print("price \(pricePicker.valueFrom)-\(pricePicker.valueTo)")
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        onClose?()
    }
    
    @IBAction func languageAction(_ sender: Any) {
        onChooseLanguage?()
    }
    
}


extension FilterViewController: PriceRangeControlDataSource {
    func rangeControl(_ rangeControl: PriceRangeControl, valueForPrice price: Double) -> Int {
        return Int(sin(price * Double.pi / 180) * 100)
    }
    
    func minPrice(in rangeControl: PriceRangeControl) -> Double {
        return 500
    }
    
    func maxPrice(in rangeControl: PriceRangeControl) -> Double {
        return 23000
    }
}
