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
    public var offer: FakeOffer!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        //show nav bar
        navigationController?.setNavigationBarHidden(false, animated: true)
        // hite title for back button
        self.navigationController?.navigationBar.backItem?.title = ""
        // add addInFavorite button
        var inFavoriteImage = "favoriteHeartNotFill"
        if offer.inFavorite {
            inFavoriteImage = "favoriteHeartFilled"
        }
        
        let image = UIImage(named: inFavoriteImage)
        image?.accessibilityFrame = CGRect(x: 0, y: 0, width: 18, height: 16)
        let addInFavoriteButton = UIBarButtonItem(image: image,
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(addToFavorite))
//        addInFavoriteButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        addInFavoriteButton.accessibilityFrame = CGRect(x: 0, y: 0, width: 36, height: 32)
//        addInFavoriteButton.customView?.contentMode = .scaleAspectFit
//        self.navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.navigationItem.rightBarButtonItem = addInFavoriteButton
//        self.navigationItem.rightBarButtonItem?.image?.accessibilityFrame = CGRect(x: 0, y: 0, width: 18, height: 16)
//        self.navigationItem.rightBarButtonItem?.image?.resizableImage(withCapInsets: .zero, resizingMode: .tile)
//
//        let but = UIButton(type: .system)
//        but.setImage(image?.withRenderingMode(.automatic), for: .normal)
//        but.frame = CGRect(x: 0, y: 0, width: 18, height: 16)
//        but.target(forAction: #selector(addToFavorite), withSender: nil)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: but)
//
        
    }
    
    @objc fileprivate func addToFavorite() {
        var inFavoriteImage = "favoriteHeartNotFill"
        if offer.inFavorite {
            inFavoriteImage = "favoriteHeartNotFill"
            offer.inFavorite = false
        } else {
            inFavoriteImage = "favoriteHeartFilled"
            offer.inFavorite = true
        }
        
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: inFavoriteImage)
        print("addToFavorite \(navigationController?.navigationBar.backItem?.accessibilityFrame.size)")
        print("addToFavorite \(navigationController?.navigationBar.backIndicatorImage?.size)")
        print("addToFavorite \(navigationItem.rightBarButtonItem?.accessibilityFrame.size)")
        print("addToFavorite \(navigationItem.rightBarButtonItem?.image?.accessibilityFrame.size)")
        print("addToFavorite \(navigationController?.navigationBar.items?.description)")
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
            cell = offerRatingInfoCell
            cell.fillData(offer: offer)
        case 2:
            let offerSocialCell = tableView.dequeueReusableCell(withIdentifier: OfferSocialCell.reuseID, for: indexPath) as! OfferSocialCell
            cell = offerSocialCell
        case 3:
            let offerReviewWatchAllCell = tableView.dequeueReusableCell(withIdentifier: OfferReviewWatchAllCell.reuseID, for: indexPath) as! OfferReviewWatchAllCell
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
