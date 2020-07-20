//
//  PicController.swift
//  Pic
//
//  Created by Igor on 08.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class PicController: BaseViewController {
    //MARK: - Constant
    var images: [UIImage] = []
    var scrollToItem: Int = 0
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Init
    ///init with Images for scrolling
    init(images: [UIImage], scrollToItem: Int) {
        super.init(nibName: nil, bundle: nil)
        self.images = images
        self.scrollToItem = scrollToItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Live Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let indexPath = IndexPath(row: scrollToItem, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    func configure() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        // Do any additional setup after loading the view.
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: size.width, height: size.height)
        layout.sectionHeadersPinToVisibleBounds = true
       
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
    }
    
    //MARK: - IBAction
    @IBAction func closeButton() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PicController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicCollectionViewCell.reuseID, for: indexPath) as! PicCollectionViewCell
        
        cell.fillData(image: images[indexPath.item])
        
        return cell
    }
}
