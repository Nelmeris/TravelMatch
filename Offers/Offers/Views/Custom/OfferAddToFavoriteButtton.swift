//
//  OfferAddToFavoriteButtton.swift
//  Offers
//
//  Created by Igor on 19.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class OfferAddToFavoriteButtton {

    private let moreButton = Button(frame: CGRect(x: 0, y: 0, width: 18, height: 16))

    public func returnButton (offer: Offer) -> Button {
        changeImageOnButton(offer: offer)
        moreButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        moreButton.imageView?.centerYAnchor.constraint(equalTo: moreButton.centerYAnchor, constant: 0.0).isActive = true
        moreButton.imageView?.trailingAnchor.constraint(equalTo: moreButton.trailingAnchor, constant: 0).isActive = true
        moreButton.imageView?.widthAnchor.constraint(equalToConstant: 18).isActive = true
        moreButton.imageView?.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        return moreButton
    }
    
    public func changeImageOnButton (offer: Offer) {
        var inFavoriteImage = "favoriteHeartNotFill"
        if offer.inFavorite {
            inFavoriteImage = "favoriteHeartFilled"
        }
        moreButton.setImage(UIImage(named: inFavoriteImage), for: .normal)
    }
}
