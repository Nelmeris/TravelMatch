//
//  OfferImageNameDescriptionCell.swift
//  Offers
//
//  Created by Igor on 04.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class OfferImageNameDescriptionCell: CustomTableViewCell {
    
    static let reuseID = "OfferImageNameDescriptionCell"

    @IBOutlet weak var offerNameLabel: UILabel!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func fillData(offer: FakeOffer) {
        offerNameLabel.text = offer.name
        offerDescriptionLabel.text = "\(offer.price) руб"
    }

}
