//
//  PicCollectionViewCell.swift
//  UI
//
//  Created by Igor on 08.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class PicCollectionViewCell: UICollectionViewCell {
    static let reuseID = "PicCollectionViewCell"

    @IBOutlet weak var pictureImageView: UIImageView!
    
    func fillData(image: UIImage) {
        pictureImageView.image = image
    }
}
