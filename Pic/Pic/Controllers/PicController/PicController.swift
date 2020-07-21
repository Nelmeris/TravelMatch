//
//  PicController.swift
//  Pic
//
//  Created by Igor on 08.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UI
import UIKit

public class PicController: BaseViewController {
    //MARK: - Constant
    public var images: [UIImage] = []
    public var scrollToItem: Int = 0
    
    // MARK: - Output
    public var didPressedCloseButton: (() -> Void)?
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Live Cycle
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    func configure() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        let size = CGSize(width: view.frame.width, height: view.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: size.width, height: size.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .horizontal
       
        collectionView!.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .black
        collectionView.backgroundColor?.withAlphaComponent(0.4)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToItemAtIndex()
    }
    
    func scrollToItemAtIndex() {
        let indexPath = IndexPath(row: scrollToItem, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    //MARK: - IBAction
    @IBAction func closeButton() {
//        navigationController?.popViewController(animated: true)
        didPressedCloseButton?()
    }
    
}

extension PicController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicCollectionViewCell.reuseID, for: indexPath) as! PicCollectionViewCell
        
        cell.fillData(image: images[indexPath.item])
        return cell
    }
}
