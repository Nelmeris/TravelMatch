//
//  InterestCollectionViewCell.swift
//  Locals
//
//  Created by Maxim Timokhin on 15.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class InterestCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var iconImageView: ImageView?
    @IBOutlet private weak var titleLabel: Label?
    
    func configure(with interest: Interest) {
        iconImageView?.imageURL = interest.iconURL
        titleLabel?.text = interest.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView?.imageURL = nil
        titleLabel?.text = nil
    }
}
