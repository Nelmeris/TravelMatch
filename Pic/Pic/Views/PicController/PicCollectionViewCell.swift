//
//  PicCollectionViewCell.swift
//  Pic
//
//  Created by Igor on 08.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class PicCollectionViewCell: UICollectionViewCell {
    static let reuseID = "PicCollectionViewCell"

    @IBOutlet weak var pictureImageView: UIImageView!
    
    func fillData(image: UIImage) {
        pictureImageView.image = image
    }
}
