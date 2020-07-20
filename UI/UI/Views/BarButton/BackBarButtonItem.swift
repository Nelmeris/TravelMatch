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

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    private func setupView() {
        self.title = nil
        self.image = UIImage(
            named: "backButton",
            in: Bundle(for: BackBarButtonItem.self),
            compatibleWith: nil
        )
    }
    
}
