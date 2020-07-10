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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
