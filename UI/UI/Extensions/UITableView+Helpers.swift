//
//  UITableView+Helpers.swift
//  UI
//
//  Created by Maxim Timokhin on 14.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func registerNib(forClass neededClass: AnyClass) {
        register(UINib(nibName: String(describing: neededClass), bundle: Bundle.main), forCellReuseIdentifier: String(describing: neededClass))
    }
    
    public func registerCell(forClass neededClass: AnyClass) {
        register(neededClass, forCellReuseIdentifier: String(describing: neededClass))
    }
    
    public func register(nib: UINib?, forHeaderFooterViewClass neededClass: AnyClass) {
        register(neededClass, forHeaderFooterViewReuseIdentifier: String(describing: neededClass))
    }
    
    public func register(forHeaderFooterViewClass neededClass: AnyClass) {
        register(neededClass, forHeaderFooterViewReuseIdentifier: String(describing: neededClass))
    }
    
    public func dequeueReusableCell<T: UITableViewCell> (forClass neededClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: neededClass), for: indexPath) as! T
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(forClass neededClass: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: neededClass)) as! T
    }
}
