//
//  OfferReviewWatchAllCell.swift
//  Offers
//
//  Created by Igor on 04.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class OfferReviewWatchAllCell: CustomTableViewCell {
    
    static let reuseID = "OfferReviewWatchAllCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func fillData(offer: Offer) {
        
    }
    
    @IBAction func showAllReviewButton() {
        print("showAllReviewButton")
    }

}
