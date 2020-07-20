//
//  ActivitiesTableViewCell.swift
//  Locals
//
//  Created by Maxim Timokhin on 19.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private var tableView: UITableView!
    
    private var items: [Activity]? {
        didSet {
            tableView.reloadData()
            contentView.setNeedsLayout()
        }
    }
    
    func configure(activities: [Activity]) {
        items = activities
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        self.tableView.layoutIfNeeded()
        let contentSize = tableView.contentSize
        
        // @todo рассчитывать высоту полностью динамически
        let viewTitleHeight: CGFloat = 80
        
        return CGSize(width: contentSize.width, height: contentSize.height + viewTitleHeight)
    }
    
}

// MARK: - UITableViewDataSource
extension ActivitiesTableViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            forClass: ActivityTableViewCell.self,
            for: indexPath
        )
        
        if let item = items?[indexPath.row]{
            cell.configure(with: item)
        }
        
        return cell
    }
    
    
}
