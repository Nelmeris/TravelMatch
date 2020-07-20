//
//  ViewControllerFactory.swift
//  Offers
//
//  Created by Igor on 28.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI
//import Pic
//import Reviews

class ViewControllerFactory {
    
    func makeListOfOffersController() -> ListOfOffersController {
        return UIStoryboard(name: "ListOfOffers", bundle: Bundle(for: ListOfOffersController.self))
            .instantiateViewController(ListOfOffersController.self)
    }
    
    func makeOfferController() -> OfferController {
        return UIStoryboard(name: "Offer", bundle: Bundle(for: OfferController.self))
            .instantiateViewController(OfferController.self)
    }
    
//    func makePicController() -> PicController {
//        return UIStoryboard(name: "Pic", bundle: Bundle(for: PicController.self))
//            .instantiateViewController(PicController.self)
//    }
//
//    func makeReviewsController() -> ReviewsController {
//        return UIStoryboard(name: "Reviews", bundle: Bundle(for: ReviewsController.self))
//            .instantiateViewController(ReviewsController.self)
//    }
    
}
