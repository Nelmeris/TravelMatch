//
//  OfferSocialCell.swift
//  Offers
//
//  Created by Igor on 04.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class OfferSocialCell: CustomTableViewCell {
    
    static let reuseID = "OfferSocialCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func fillData(offer: FakeOffer) {
        
    }
    
    @IBAction func facebookButton() {
        print("facebookButton")
    }
    @IBAction func instagramButton() {
        print("instagramButton")
    }
    @IBAction func whatsappButton() {
        print("whatsappButton")
    }
    @IBAction func tumblrButton() {
        print("tumblrButton")
    }
    @IBAction func twitterButton() {
        print("twitterButton")
    }
    
}
