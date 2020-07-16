//
//  AboutTableViewCell.swift
//  Locals
//
//  Created by Maxim Timokhin on 10.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class AboutTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: Label?
    @IBOutlet weak var aboutLabel: Label?
    
    func configure(title: String, aboutText: String) {
        titleLabel?.text = title
        aboutLabel?.text = aboutText
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel?.text = nil
        aboutLabel?.text = nil
    }
    
}
