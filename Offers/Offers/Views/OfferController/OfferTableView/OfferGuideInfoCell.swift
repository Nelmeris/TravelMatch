//
//  OfferGuideInfoCell.swift
//  Offers
//
//  Created by Igor on 04.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class OfferGuideInfoCell: CustomTableViewCell {
    
    static let reuseID = "OfferGuideInfoCell"

    @IBOutlet weak var guidePhotoImageView: UIImageView!
    @IBOutlet weak var guideNameLabel: UILabel!
    @IBOutlet weak var guideHobbiesLabel: UILabel!
    @IBOutlet weak var sendMessageButtonOutlet: Button! {
        didSet{
            let edges = UIEdgeInsets(top: 13, left: 11, bottom: 13, right: 11)
            sendMessageButtonOutlet.imageEdgeInsets = edges
        }
    }
    @IBOutlet weak var guideInfoLabel: UILabel!

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
        guidePhotoImageView.layer.cornerRadius = cornerRadius
    }
    
    override func fillData(offer: FakeOffer) {
        
    }

    @IBAction func sendMessageButtonAction() {
        print("sendMessageButtonAction")
    }
}
