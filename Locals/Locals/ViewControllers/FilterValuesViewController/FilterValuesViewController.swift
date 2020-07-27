//
//  FilterValuesViewController.swift
//  Locals
//
//  Created by Maxim Timokhin on 25.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

struct FilterValue {
    let title: String
}

class FilterValuesViewController: BaseViewController {

    // MARK: - Input

    override var title: String? {
        didSet{
            updateView()
        }
    }
    
    var values: [FilterValue]? {
        didSet {
            updateView()
            tableView?.reloadData()
        }
    }

    // MARK: - Output
    
    var onChangeSelection: ((_ indicies: [Int]) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var titleLabel: Label!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Update view
    
    private func updateView() {
        titleLabel?.text = title
                
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel?.text = title
        
        if #available(iOS 13.0, *) {
            closeButton.isHidden = true
        }
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource

extension FilterValuesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            forClass: FilterValueTableViewCell.self,
            for: indexPath
        )

        if let value = values?[indexPath.row] {
            cell.configure(with: value)
        }
        
        return cell
    }

}

// MARK: - UITableViewDelegate

extension FilterValuesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indicies = tableView.indexPathsForSelectedRows?.map {$0.row} ?? []
        onChangeSelection?(indicies)
    }
 
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let indicies = tableView.indexPathsForSelectedRows?.map {$0.row} ?? []
        onChangeSelection?(indicies)
    }
    
}
