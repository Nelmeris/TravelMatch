//
//  ReviewsTableViewCell.swift
//  UI
//
//  Created by Igor on 08.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import Models

class ReviewsTableViewCell: UITableViewCell, ConfigurableCell {
    
    typealias ViewModel = Review
    
    static var reuseIdentifier: String {
        return "ReviewsTableViewCell"
    }
    
    @IBOutlet weak var reviewOwnerImageView: UIImageView!
    @IBOutlet weak var reviewOwnerNameLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var reviewDescriptionLabel: UILabel!
    
    func configure(_ viewModel: Review, at indexPath: IndexPath) {
        reviewOwnerImageView.image = viewModel.ownerImage
        reviewOwnerNameLabel.text = viewModel.ownerName
        let date = Date()
        reviewDateLabel.text = date.getMonthYear(date: viewModel.date)
        reviewDescriptionLabel.text = viewModel.description
    }
    
}
