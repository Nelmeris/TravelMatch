//
//  PicController.swift
//  Pic
//
//  Created by Igor on 08.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UI
import UIKit

class PicController: BaseViewController {
    //MARK: - Constant
    private var images: [UIImage] = MockFakeDataPic.data.images
    public var impressionID: Int?
    public var offerID: Int?
    public var scrollToItem: Int = 0
    
    // MARK: - Output
    var didPressedCloseButton: (() -> Void)?
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Live Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: size.width, height: size.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .black
        collectionView.backgroundColor?.withAlphaComponent(0.4)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToItemAtIndex()
    }
    
    func scrollToItemAtIndex() {
        let indexPath = IndexPath(row: scrollToItem, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    //MARK: - IBAction
    @IBAction func closeButton() {
        didPressedCloseButton?()
    }
    
}

extension PicController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicCollectionViewCell.reuseID, for: indexPath) as! PicCollectionViewCell
        
        cell.fillData(image: images[indexPath.item])
        return cell
    }
}
