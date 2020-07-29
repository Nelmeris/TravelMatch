//
//  ImageView.swift
//  UI
//
//  Created by Maxim Timokhin on 06.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import SDWebImage

public class ImageView: UIImageView {

    public var imageURL: URL? {
        didSet {
            sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            sd_setImage(with: imageURL, completed: nil)
        }
    }

}
