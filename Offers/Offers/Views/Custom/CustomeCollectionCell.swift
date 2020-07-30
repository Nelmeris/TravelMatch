//
//  CustomeCollectionCell.swift
//  Offers
//
//  Created by Igor on 03.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import UIKit
import UI

protocol CustomeCollectionCellProtocol: class {
    func fillData(filter: String)
    func fillData(image: UIImage)
}

class CustomeCollectionCell: UICollectionViewCell, CustomeCollectionCellProtocol {
    func fillData(filter: String) {
    }
    func fillData(image: UIImage) {
    }
}
