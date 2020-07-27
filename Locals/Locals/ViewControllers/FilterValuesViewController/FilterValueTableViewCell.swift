//
//  FilterValueTableViewCell.swift
//  Locals
//
//  Created by Maxim Timokhin on 27.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class FilterValueTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var checkBox: CheckboxControl!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkBox.isChecked = selected
    }

    func configure(with value: FilterValue) {
        valueLabel.text = value.title
    }
    
}
