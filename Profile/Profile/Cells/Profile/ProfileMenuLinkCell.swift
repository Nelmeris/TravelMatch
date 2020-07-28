//
//  ProfileMenuLinkCell.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UI
import UIKit

class ProfileMenuLinkCell: UITableViewCell, ConfigurableCell {
    
    typealias ViewModel = String
    
    static var reuseIdentifier: String {
        return "ProfileMenuLinkCell"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ viewModel: String, at indexPath: IndexPath) {
        titleLabel.text = viewModel
    }
    
}
