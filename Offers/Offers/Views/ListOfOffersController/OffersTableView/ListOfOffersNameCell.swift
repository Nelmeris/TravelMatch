//
//  ListOfOffersNameCell.swift
//  Offers
//
//  Created by Igor on 29.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class ListOfOffersNameCell: CustomTableViewCell {
    
    static let reuseID = "ListOfOffersNameCell"

    @IBOutlet weak var offerNameLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func fillData(offer: Offer) {
        offerNameLabel.text = offer.name
        offerPriceLabel.text = "\(offer.price) руб"
    }

}
