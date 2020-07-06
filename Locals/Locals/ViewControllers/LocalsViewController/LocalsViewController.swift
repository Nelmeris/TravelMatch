//
//  LocalsViewController.swift
//  Locals
//
//  Created by Maxim Timokhin on 01.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

enum LocalsViewControllerState {
    case initial([Local])
    case loading
    case error(String)
}

class LocalsViewController: BaseViewController {

    // MARK: - Input
    var state: LocalsViewControllerState? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    var onLocalSelected: ((Local) -> Void)?
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    private var locals: [Local]? {
        didSet {
            collectionView?.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }

    // MARK: - Update view
    private func updateView() {
        guard let state = state else { return }
        
        switch state {
        case .loading:
            showActivityIndicator()
        case .initial(let locals):
            hideActivityIndicator()
            self.locals = locals
        case .error(let error):
            hideActivityIndicator()
            showCommonError(error)
        }
    }
    

}

// MARK: - UICollectionViewDataSource
extension LocalsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locals?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            forClass: LocalsCollectionViewCell.self,
            for: indexPath
        )

        if let local = locals?[indexPath.row] {
            cell.configure(with: local)
        }
        
        return cell
    }

}


// MARK: - UICollectionViewDelegateFlowLayout
extension LocalsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        let textLabelsHeight: CGFloat = 70
        
        return CGSize(
            width: collectionViewSize/2,
            height: collectionViewSize/2 + textLabelsHeight
        )
    }
    
}
