//
//  OfferLastThreeReviewsCell.swift
//  Offers
//
//  Created by Igor on 04.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI
import Models

class OfferLastThreeReviewsCell: CustomTableViewCell {
    
    static let reuseID = "OfferLastThreeReviewsCell"

    @IBOutlet weak var firstReviewOwnerImageLabel: UIImageView!
    @IBOutlet weak var firstReviewOwnerNameLabel: UILabel!
    @IBOutlet weak var firstReviewDateLabel: UILabel!
    @IBOutlet weak var firstReviewTextLabel: UILabel!
    @IBOutlet weak var secondReviewOwnerImageLabel: UIImageView!
    @IBOutlet weak var secondReviewOwnerNameLabel: UILabel!
    @IBOutlet weak var secondReviewDateLabel: UILabel!
    @IBOutlet weak var secondReviewTextLabel: UILabel!
    @IBOutlet weak var thirdReviewOwnerImageLabel: UIImageView!
    @IBOutlet weak var thirdReviewOwnerNameLabel: UILabel!
    @IBOutlet weak var thirdReviewDateLabel: UILabel!
    @IBOutlet weak var thirdReviewTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        let cornerRadius:CGFloat = 10
        firstReviewOwnerImageLabel.layer.cornerRadius = cornerRadius
        secondReviewOwnerImageLabel.layer.cornerRadius = cornerRadius
        thirdReviewOwnerImageLabel.layer.cornerRadius = cornerRadius
    }
    
    override func fillData(offer: FakeOffer) {
        
    }

}
