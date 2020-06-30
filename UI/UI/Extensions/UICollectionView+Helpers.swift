//
//  UICollectionView+Helpers.swift
//  UI
//
//  Created by Maxim Timokhin on 29.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    func registerNib(forClass neededClass: AnyClass) {
        register(UINib(nibName: String(describing: neededClass), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: neededClass))
    }
    
    func registerCell(forClass neededClass: AnyClass) {
        register(neededClass, forCellWithReuseIdentifier: String(describing: neededClass))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell> (forClass neededClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: neededClass), for: indexPath) as! T
    }
    
}
