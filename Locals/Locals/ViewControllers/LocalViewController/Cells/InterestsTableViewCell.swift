//
//  InterestsTableViewCell.swift
//  Locals
//
//  Created by Maxim Timokhin on 14.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class InterestsTableViewCell: UITableViewCell {

    // MARK: - Output
    var onInterestSelected: ((Interest) -> Void)?
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var items: [Interest]?
    
    func configure(interests: [Interest]) {
        items = interests
        collectionView.reloadData()
        contentView.setNeedsLayout()
    }
}

// MARK: - UICollectionViewDataSource

extension InterestsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            forClass: InterestCollectionViewCell.self,
            for: indexPath
        )

        if let item = items?[indexPath.row]{
            cell.configure(with: item)
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension InterestsTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let interest = items?[indexPath.row] else { return }
        onInterestSelected?(interest)
    }    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension InterestsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        self.collectionView.layoutIfNeeded()
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        
        let viewTitleHeight: CGFloat = 80
        
        return CGSize(width: contentSize.width, height: contentSize.height + viewTitleHeight)
    }
    
}
