//
//  ListOfOffersFilterCollectionCell.swift
//  Offers
//
//  Created by Igor on 29.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class ListOfOffersFilterCollectionCell: CustomeCollectionCell {
    
    static let reuseID = "ListOfOffersFilterCollectionCell"
    
    @IBOutlet weak var offersFilterLabel: UILabel!
    
    override func fillData(filter: String) {
        offersFilterLabel.text = filter
    }
}
