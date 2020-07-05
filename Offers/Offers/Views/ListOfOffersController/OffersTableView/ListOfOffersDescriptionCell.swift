//
//  ListOfOffersDescriptionCell.swift
//  Offers
//
//  Created by Igor on 29.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class ListOfOffersDescriptionCell: CustomTableViewCell {
    
    static let reuseID = "ListOfOffersDescriptionCell"
    
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
        offerDescriptionLabel.text = offer.description
    }
}
