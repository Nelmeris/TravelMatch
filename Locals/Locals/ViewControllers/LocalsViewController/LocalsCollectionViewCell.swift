//
//  LocalsCollectionViewCell.swift
//  Locals
//
//  Created by Maxim Timokhin on 05.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class LocalsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet private var imageView: ImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var tagsLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    
    
    func configure(with local: Local) {
        imageView?.imageURL = local.imageURL
        nameLabel?.text = local.name
        tagsLabel?.text = local
            .interests
            .map{$0.title}
            .joined(separator: " • ")
        
        if local.price > 0 {
            priceLabel?.text = "\(local.price) \(local.priceDescriptor)"
        } else {
            priceLabel?.text = "бесплатно"
        }
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.imageURL = nil
        nameLabel?.text = nil
        tagsLabel?.text = nil
        priceLabel?.text = nil
    }
    
}

