//
//  OfferReviewWatchAllCell.swift
//  Offers
//
//  Created by Igor on 04.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

@objc protocol OfferReviewWatchAllCellDelegate: class {
    @objc optional func didPressedShowAllReviewsButton()
}

class OfferReviewWatchAllCell: CustomTableViewCell, OfferReviewWatchAllCellDelegate {

    static let reuseID = "OfferReviewWatchAllCell"
    
    weak var delegate: OfferReviewWatchAllCellDelegate?

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
        delegate?.didPressedShowAllReviewsButton?()
    }

}


