//
//  ListOfOffersImageCell.swift
//  Offers
//
//  Created by Igor on 29.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI
import Models

class ListOfOffersImageCell: CustomTableViewCell {
    
    static let reuseID = "ListOfOffersImageCell"
    
    @IBOutlet weak var offerPictureImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
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
        offerPictureImageView.layer.cornerRadius = 20
    }
    
    override func fillData(offer: FakeOffer) {
        let image = offer.image
        offerPictureImageView.image = UIImage(named: image, in: Bundle(for: ListOfOffersController.self), compatibleWith: nil)
        var name = "favoriteHeartNotFill"
        if !offer.inFavorite {
            name = "favoriteHeartNotFill"
        } else {
            name = "favoriteHeartFilled"
        }
        favoriteImageView.image = UIImage(named: name, in: Bundle(for: ListOfOffersController.self), compatibleWith: nil)
    }

}
