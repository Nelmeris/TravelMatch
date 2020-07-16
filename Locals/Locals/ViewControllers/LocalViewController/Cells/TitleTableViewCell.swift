//
//  TitleTableViewCell.swift
//  Locals
//
//  Created by Maxim Timokhin on 10.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class TitleTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var avatarImageView: ImageView?
    @IBOutlet private weak var nameLabel: Label?
    
    func configure(imageURL: URL, name: String) {
        avatarImageView?.imageURL = imageURL
        nameLabel?.text = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView?.imageURL = nil
        nameLabel?.text = nil
    }

}
