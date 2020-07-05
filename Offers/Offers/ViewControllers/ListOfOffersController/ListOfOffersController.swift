//
//  ListOfOffersController.swift
//  Offers
//
//  Created by Igor on 28.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import Core
import UI
import CVCalendar

class ListOfOffersController: BaseViewController {
    //MARK: - Constants
    
    let refreshControler = UIRefreshControl()
    var offers: [FakeOffer] = MockFakeData.data.getOffers(count: 7)
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Controller Livecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        configureRefreshControl()
        configureCalendarView()
        configureCollectionView()
        configureTableView()
    }
    //MARK: - Refresh Control
    func configureRefreshControl() {
        refreshControler.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControler)
    }
    
    @objc func didPullToRefresh() {
        tableView.reloadData()
        // For End refrshing
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.refreshControler.endRefreshing()
        }
    }
    //MARK: - Calendar
    func configureCalendarView() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarMenuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    //MARK: - Collection View
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    //MARK: - Table View
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}

extension ListOfOffersController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MockFakeData.data.filterCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListOfOffersFilterCollectionCell.reuseID, for: indexPath) as! ListOfOffersFilterCollectionCell
        
        cell.fillData(filter: MockFakeData.data.filterCollection[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(MockFakeData.data.filterCollection[indexPath.item])")
       
        offers = MockFakeData.data.getOffers(count: indexPath.item + 1)
        tableView.reloadData()
    }
    
}

extension ListOfOffersController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CustomTableViewCell!
 
        switch indexPath.row {
        case 0:
            let offerImageCell = tableView.dequeueReusableCell(withIdentifier: ListOfOffersImageCell.reuseID, for: indexPath) as! ListOfOffersImageCell
            cell = offerImageCell
        case 1:
            let offerNameCell = tableView.dequeueReusableCell(withIdentifier: ListOfOffersNameCell.reuseID, for: indexPath) as! ListOfOffersNameCell
            cell = offerNameCell
        case 2:
            let offerDescriptionCell = tableView.dequeueReusableCell(withIdentifier: ListOfOffersDescriptionCell.reuseID, for: indexPath) as! ListOfOffersDescriptionCell
            cell = offerDescriptionCell
        default:
            break
        }
        cell.fillData(offer: offers[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Offer", bundle: Bundle(for: OfferController.self))
        let offerController = storyBoard.instantiateViewController(withIdentifier: "OfferController") as! OfferController
        offerController.offer = offers[indexPath.section]
        navigationController?.pushViewController(offerController, animated: true)
    }
}
