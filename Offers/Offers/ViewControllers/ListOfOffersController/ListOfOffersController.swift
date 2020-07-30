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
    
    private var currentCalendar: Calendar?
    private var animationFinished = true
    private var selectedDay: DayView?
    private let refreshControler = UIRefreshControl()
    public var mockFakeDataService: OffersService?
    
    var offers: [Offer] = []
    
    // MARK: - Output
    
    var onOfferController: ((Offer) -> Void)?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var currentMonthOnCalendarLabel: UILabel!
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Controller Livecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configure()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offers = mockFakeDataService?.getOffers(count: 9) ?? []
    }
    
    func configure() {
        configureRefreshControl()
        configureCalendar()
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
    func configureCalendar() {
//        let timeZoneBias = 180 // (UTC+03:00)
//        if let timeZone = TimeZone(secondsFromGMT: -timeZoneBias * 60) {
//            currentCalendar?.timeZone = timeZone
//        }
        
        currentCalendar = Calendar(identifier: .gregorian)
        currentCalendar?.locale = Locale.current
        currentCalendar?.timeZone = TimeZone.current
                
        if let currentCalendar = currentCalendar {
            currentMonthOnCalendarLabel.text = CVDate(date: Date(), calendar: currentCalendar).globalDescription
        }
        configureCalendarView()
    }
    
    func configureCalendarView() {
        calendarView.calendarAppearanceDelegate = self
        calendarView.animatorDelegate = self
        calendarMenuView.menuViewDelegate = self
        calendarView.calendarDelegate = self
        self.view.layoutIfNeeded()
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
    
    //MARK: - IBActions

    @IBAction func loadPreviousWeekButton() {
       calendarView.loadPreviousView()
    }
    
    @IBAction func loadNextWeekButton() {
        calendarView.loadNextView()
    }
}

//MARK: - CVCalendar Delegate

extension ListOfOffersController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    func shouldShowWeekdaysOut() -> Bool { return true }
    func calendar() -> Calendar? { return currentCalendar }

    
    func presentationMode() -> CalendarMode {
        return .weekView
    }
    
    func firstWeekday() -> Weekday {
        return CVCalendar.Weekday.monday
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        print("\(String(describing: dayView.date.convertedDate()))")
        selectedDay = dayView
        print("\(String(describing: selectedDay?.date.commonDescription))")
        print("\(String(describing: selectedDay?.date.globalDescription))")
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        if currentMonthOnCalendarLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = currentMonthOnCalendarLabel.textColor
            updatedMonthLabel.font = currentMonthOnCalendarLabel.font
            updatedMonthLabel.textAlignment = .center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.currentMonthOnCalendarLabel.center
            
            updatedMonthLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.5)
            
            UIView.animate(withDuration: 0.35, delay: 0, options: .curveLinear, animations: {
                self.animationFinished = false
                self.currentMonthOnCalendarLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.5)
                self.currentMonthOnCalendarLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransform.identity
                
            }) { _ in
                
                self.animationFinished = true
                self.currentMonthOnCalendarLabel.frame = updatedMonthLabel.frame
                self.currentMonthOnCalendarLabel.text = updatedMonthLabel.text
                self.currentMonthOnCalendarLabel.transform = CGAffineTransform.identity
                self.currentMonthOnCalendarLabel.alpha = 1
                updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.currentMonthOnCalendarLabel)
        }
    }
}

//MARK: - Collection View Delegate & DataSource
extension ListOfOffersController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockFakeDataService?.filterCollection.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListOfOffersFilterCollectionCell.reuseID, for: indexPath) as! ListOfOffersFilterCollectionCell
        
        if let filter = mockFakeDataService?.filterCollection[indexPath.item] {
            cell.fillData(filter: filter)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(mockFakeDataService?.filterCollection[indexPath.item] ?? "")")
       
        offers = mockFakeDataService?.getOffers(count: indexPath.item + 1) ?? []
        tableView.reloadData()
    }
    
}

//MARK: - Table View Delegate & DataSource
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
        onOfferController?(offers[indexPath.section])
    }
}
