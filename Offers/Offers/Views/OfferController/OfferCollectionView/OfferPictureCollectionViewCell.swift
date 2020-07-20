//
//  OfferPictureCollectionViewCell.swift
//  Offers
//
//  Created by Igor on 04.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

class OfferPictureCollectionViewCell: CustomeCollectionCell {
    static let reuseID = "OfferPictureCollectionViewCell"
    
    @IBOutlet weak var offerPictureImageView: UIImageView! {
        didSet{
                let cornerRadius:CGFloat = 10
                offerPictureImageView.layer.cornerRadius = cornerRadius
        }
    }
    
    override func fillData(image: String) {
        offerPictureImageView.image = UIImage(named: image,
                                              in: Bundle(for: OfferPictureCollectionViewCell.self),
                                              compatibleWith: nil)
    }
    
}
