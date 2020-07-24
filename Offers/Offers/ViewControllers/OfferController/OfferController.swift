//
//  OfferController.swift
//  Offers
//
//  Created by Igor on 29.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import Core
import UI

class OfferController: BaseViewController {

    //MARK: - Constants
    
    public var offer: FakeOffer!
    private let addToFavoriteButtton = OfferAddToFavoriteButtton()
    
    // MARK: - Output
    var onPicController: ((Int, Int) -> Void)?
    var onReviewsController: ((Int) -> Void)?
    var onSocialButtonClicked: ((FakeOffer) -> Void)?
    var onSendMessageButtonClicked: ((FakeOffer) -> Void)?
    var onBookingDetail: ((FakeOffer) -> Void)?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Controller Livecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        configureNavigationBar()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
    }
    
    // MARK: NavigationBar configurate
    func configureNavigationBar() {
        // hite title for back button
        self.navigationController?.navigationBar.topItem?.title = ""
        // add addInFavorite button
        let inFavoriteButton = addToFavoriteButtton.returnButton(offer: offer)
        inFavoriteButton.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: inFavoriteButton)
    }
    
    @objc fileprivate func addToFavorite() {
        if offer.inFavorite {
            offer.inFavorite = false
        } else {
            offer.inFavorite = true
        }
        addToFavoriteButtton.changeImageOnButton(offer: offer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

extension OfferController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let staticCellCount = 7
        return staticCellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CustomTableViewCell!
        
        switch indexPath.row {
        case 0:
            let offerImageNameDescriptionCell = tableView.dequeueReusableCell(withIdentifier: OfferImageNameDescriptionCell.reuseID, for: indexPath) as! OfferImageNameDescriptionCell
            offerImageNameDescriptionCell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            cell = offerImageNameDescriptionCell
        case 1:
            let offerRatingInfoCell = tableView.dequeueReusableCell(withIdentifier: OfferRatingInfoCell.reuseID, for: indexPath) as! OfferRatingInfoCell
            offerRatingInfoCell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            offerRatingInfoCell.delegate = self
            cell = offerRatingInfoCell
            cell.fillData(offer: offer)
        case 2:
            let offerSocialCell = tableView.dequeueReusableCell(withIdentifier: OfferSocialCell.reuseID, for: indexPath) as! OfferSocialCell
            cell = offerSocialCell
        case 3:
            let offerReviewWatchAllCell = tableView.dequeueReusableCell(withIdentifier: OfferReviewWatchAllCell.reuseID, for: indexPath) as! OfferReviewWatchAllCell
            offerReviewWatchAllCell.delegate = self
            cell = offerReviewWatchAllCell
        case 4:
            let offerLastThreeReviewsCell = tableView.dequeueReusableCell(withIdentifier: OfferLastThreeReviewsCell.reuseID, for: indexPath) as! OfferLastThreeReviewsCell
            cell = offerLastThreeReviewsCell
        case 5:
            let offerGuideInfoCell = tableView.dequeueReusableCell(withIdentifier: OfferGuideInfoCell.reuseID, for: indexPath) as! OfferGuideInfoCell
            offerGuideInfoCell.separatorInset = UIEdgeInsets.zero
            cell = offerGuideInfoCell
        case 6:
            let offerBookingCell = tableView.dequeueReusableCell(withIdentifier: OfferBookingCell.reuseID, for: indexPath) as! OfferBookingCell
            cell = offerBookingCell
        default:
            break
        }
        
//        cell.fillData(offer: offer)
        return cell
    }
    
    // MARK: - Navigation Bar Hide logic
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}

extension OfferController: OfferRatingInfoCellCollectionDelegate {
    func didSelectItem(index: Int) {
        onPicController?(offer.id, index)
    }
}

extension OfferController: OfferReviewWatchAllCellDelegate {
    func didPressedShowAllReviewsButton() {
        let offerID = offer.id
        onReviewsController?(offerID)
    }
}
