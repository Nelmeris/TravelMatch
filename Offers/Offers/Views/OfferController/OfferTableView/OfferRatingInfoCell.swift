//
//  OfferRatingInfoCell.swift
//  Offers
//
//  Created by Igor on 04.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI
import Pic

protocol OfferRatingInfoCellCollectionDelegate: class {
    func didSelectItem(images: [UIImage], index: Int)
}

class OfferRatingInfoCell: CustomTableViewCell, OfferRatingInfoCellCollectionDelegate {

    static let reuseID = "OfferRatingInfoCell"
    var imageCollection: [UIImage] = []
    weak var delegate: OfferRatingInfoCellCollectionDelegate?

    @IBOutlet weak var firstStarImageView: UIImageView!
    @IBOutlet weak var secondStarImageView: UIImageView!
    @IBOutlet weak var thirdStarImageView: UIImageView!
    @IBOutlet weak var fourthStarImageView: UIImageView!
    @IBOutlet weak var fifthStarImageView: UIImageView!
    @IBOutlet weak var ratingCounterLabel: UILabel!
    @IBOutlet weak var excursionTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func fillData(offer: FakeOffer) {
        var images = MockFakeDataPic.data.getPictures(count: 9)
        images.shuffle()
        imageCollection = images
        collectionView.reloadData()
    }
    
    func didSelectItem(images: [UIImage], index: Int) {
        
    }
}

extension OfferRatingInfoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfferPictureCollectionViewCell.reuseID, for: indexPath) as! OfferPictureCollectionViewCell
        
        cell.fillData(image: imageCollection[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(indexPath.item)")
        delegate?.didSelectItem(images: imageCollection, index: indexPath.item)
    }
    
}
