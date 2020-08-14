//
//  BarButtonItem.swift
//  UI
//
//  Created by Maxim Timokhin on 07.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public class BarButtonItem: UIBarButtonItem {
    
    public override init() {
        super.init()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        tintColor = UIColor.Buttons.secondaryTextColor
    }
        
}
