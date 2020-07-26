//
//  QuestionCollectionViewCell.swift
//  Questions
//
//  Created by Maxim Timokhin on 29.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import SDWebImage
import Models

class QuestionCollectionViewCell: UICollectionViewCell {
 
    override var isSelected: Bool {
        didSet {
            checkmarkView?.isHidden = !isSelected
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var checkmarkView: UIImageView?
    
    func configure(with answer: TravelAnswer) {
        imageView?.sd_setImage(with: answer.imageURL, completed: nil)
        titleLabel?.text = answer.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
        titleLabel?.text = nil
    }
    
}
