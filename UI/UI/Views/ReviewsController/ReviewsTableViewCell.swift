//
//  ReviewsTableViewCell.swift
//  UI
//
//  Created by Igor on 08.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    static let reuseID = "ReviewsTableViewCell"
    
    @IBOutlet weak var reviewOwnerImageView: UIImageView!
    @IBOutlet weak var reviewOwnerNameLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var reviewDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillData(review: Review) {
        reviewOwnerImageView.image = review.ownerImage
        reviewOwnerNameLabel.text = review.ownerName
        let date = Date()
        reviewDateLabel.text = date.getMonthYear(date: review.date)
        reviewDescriptionLabel.text = review.description
    }

}
