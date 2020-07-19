//
//  CustomTableViewCell.swift
//  Offers
//
//  Created by Igor on 03.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import UIKit
import UI

protocol CustomTableViewCellProtocol: class {
    func fillData(offer: FakeOffer)
}

class CustomTableViewCell: UITableViewCell, CustomTableViewCellProtocol {
    func fillData(offer: FakeOffer) {
    }
}