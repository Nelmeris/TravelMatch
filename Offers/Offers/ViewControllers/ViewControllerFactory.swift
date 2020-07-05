//
//  ViewControllerFactory.swift
//  Offers
//
//  Created by Igor on 28.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class ViewControllerFactory {
    
    func makeListOfOffersController() -> ListOfOffersController {
        return UIStoryboard(name: "ListOfOffers", bundle: Bundle(for: ListOfOffersController.self))
        .instantiateViewController(ListOfOffersController.self)
    }
    
    func makeOfferController() -> OfferController {
        return UIStoryboard(name: "Offer", bundle: Bundle(for: OfferController.self))
        .instantiateViewController(OfferController.self)
    }
    
}
