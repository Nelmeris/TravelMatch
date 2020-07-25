//
//  OfferBookingCell.swift
//  Offers
//
//  Created by Igor on 04.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI
import CVCalendar
import Models

class OfferBookingCell: CustomTableViewCell {
    
    static let reuseID = "OfferBookingCell"

    @IBOutlet weak var offerDayLabel: UILabel!
    
    @IBOutlet weak var bookingNowButtonOutlet: Button!
    
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

    @IBAction func previousDayButton() {
        print("previousDayButton")
    }
    
    @IBAction func nextDayButton() {
        print("nextDayButton")
    }
    
    @IBAction func bookingNowButtonAction() {
        print("bookingNowButtonAction")
    }
}
