//
//  LocalViewController.swift
//  Locals
//
//  Created by Maxim Timokhin on 09.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class LocalViewController: BaseViewController {

    enum Section: Int, CaseIterable {
        case header
        case about
        case interesets
        case languages
        case activities
        case reviews
    }
    
    // MARK: - Input
    var local: Local? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Outpu
    var onInterestClicked: ((Interest) -> Void)?
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        updateView()
    }
    
    // MARK: - Update view
    private func updateView() {
        tableView?.reloadData()
    }

}

// MARK: - UITableViewDataSource

extension LocalViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let local = local,
              let viewSection = Section(rawValue: section)
            else { return 0 }
        
        switch viewSection {
        case .header:
            return 1
        case .about:
            return 1
        case .interesets:
            return local.interests.isEmpty ? 0 : 1
        case .languages:
            return local.languages.isEmpty ? 0 : 1
        case .activities:
            return local.activities.isEmpty ? 0 : 1
        case .reviews:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let local = local,
            let viewSection = Section(rawValue: indexPath.section)
            else { return UITableViewCell() }
        
        switch viewSection {
        case .header:
            let cell = tableView.dequeueReusableCell(
                forClass: TitleTableViewCell.self,
                for: indexPath
            )            
            cell.configure(imageURL: local.imageURL, name: local.name)
            return cell
        case .about:
            let cell = tableView.dequeueReusableCell(
                forClass: AboutTableViewCell.self,
                for: indexPath
            )
            cell.configure(title: "Обо мне", aboutText: local.aboutText)
            return cell
        case .interesets:
            let cell = tableView.dequeueReusableCell(
                forClass: InterestsTableViewCell.self,
                for: indexPath
            )
            cell.onInterestSelected = { [weak self] interest in
                self?.onInterestClicked?(interest)
            }
            cell.configure(interests: local.interests)
            return cell
        case .languages:
            return UITableViewCell()
        case .activities:
            return UITableViewCell()
        case .reviews:
            return UITableViewCell()
        }
        
        
    }
                
}
