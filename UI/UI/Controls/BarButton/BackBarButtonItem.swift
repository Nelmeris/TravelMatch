//
//  BackBarButtonItem.swift
//  UI
//
//  Created by Maxim Timokhin on 19.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class BackBarButtonItem: UIBarButtonItem {
    
    public override init() {
        super.init()
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        title = nil
        image = UIImage(
            named: "backButton",
            in: Bundle(for: BackBarButtonItem.self),
            compatibleWith: nil
        )
    }
    
}
