//
//  ActivityTableViewCell.swift
//  Locals
//
//  Created by Maxim Timokhin on 19.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private var titleLabel: UILabel!
    
    func configure(with activity: Activity) {
        titleLabel.text = activity.title
    }
    
}
