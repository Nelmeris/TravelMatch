//
//  LanguageTableViewCell.swift
//  Locals
//
//  Created by Maxim Timokhin on 19.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class LanguageTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var progressView: ProgressView!
    
    func configure(with language: Language) {
        titleLabel.text = language.title
        progressView.value = language.level
    }
}
