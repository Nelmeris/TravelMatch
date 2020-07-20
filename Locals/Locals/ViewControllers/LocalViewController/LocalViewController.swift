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
    
    // MARK: - Output
    var onInterestClicked: ((Interest) -> Void)?
    var onBookingClicked: (() -> Void)?
    var onMessageClicked: (() -> Void)?
    
    // MARK: - Outlets
    @IBOutlet private var headerView: HeaderView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var backButton: BackBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigationController?.navigationBar.topItem?.title = ""
        updateView()
    }
    
    // MARK: - Update view
    private func updateView() {
        guard let local = local else { return }
        tableView?.reloadData()
        headerView?.configure(with: local.imageLargeURL, title: local.name)
    }

    // MARK: - Actions
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookingButtonClicked(_ sender: Any) {
        onBookingClicked?()
    }
    
    @IBAction func messageClickedAction(_ sender: Any) {
        onMessageClicked?()
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
             let cell = tableView.dequeueReusableCell(
                forClass: LanguagesTableViewCell.self,
                for: indexPath
            )
            cell.configure(languages: local.languages)
            return cell
        case .activities:
             let cell = tableView.dequeueReusableCell(
                forClass: ActivitiesTableViewCell.self,
                for: indexPath
            )
             cell.configure(activities: local.activities)
            return cell
        case .reviews:
            return UITableViewCell()
        }
        
        
    }
                
}

// MARK: - UIScrollViewDelegate
extension LocalViewController: UIScrollViewDelegate {
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollTop = scrollView.contentOffset.y
                    
        if scrollTop <= 0 {
            headerView.contentView.transform = CGAffineTransform(translationX: 0, y: scrollTop)
            headerView.imageView.transform = .identity
        } else {
            headerView.imageView.transform = CGAffineTransform(translationX: 0, y: scrollTop / 2)
        }
    }

    
}
