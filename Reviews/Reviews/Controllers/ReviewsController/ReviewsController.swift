//
//  ReviewsController.swift
//  Reviews
//
//  Created by Igor on 08.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI

class ReviewsController: BaseViewController {
    //MARK: - Constant
    public var offerID: Int = 0
    public var impressionID: Int = 0
    private var reviews: [Review] = []
    public var isHiddenSendReviewView: Bool = true
    
    var keyboardHeightOldValue: CGFloat = 0
    
    // MARK: - Output
    var didPressedCloseButton: (() -> Void)?
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var reviewSuperView: UIView!
    @IBOutlet weak var controllerNamelabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reviewTextField: TextField!
    @IBOutlet weak var sendReviewButtonOutlet: Button!
    @IBOutlet weak var sendReviewView: UIView!
    
    //MARK: - Init
    ///init with Images for scrolling
    
    //MARK: - Live Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let randonInt = Int.random(in: 5...16)
        reviews = MockFakeDataReviews.data.getReviews(count: randonInt)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configure()
    }
    
    func configure() {
        addGesture()
        configureTableView()
        configureSendReviewView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func configureSendReviewView() {
        if isHiddenSendReviewView {
            sendReviewView.translatesAutoresizingMaskIntoConstraints = false
            sendReviewView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
    }
    
    //MARK: - Gestures
    func addGesture() {
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGR)
        
        //Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func keyboardChange(notification: Notification) {
        let info = notification.userInfo as NSDictionary?
        let keyboardHeight = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size.height
        var contentInsets: UIEdgeInsets?
        let spotterHeigh: CGFloat = 24
        
        print("⌨️ Keyboard Height Was => \(self.keyboardHeightOldValue)")
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            contentInsets = UIEdgeInsets(top: 0,
                                         left: 0,
                                         bottom: keyboardHeight - spotterHeigh,
                                         right: 0)
            print("⌨️ will show")
        } else if notification.name == UIResponder.keyboardWillHideNotification {
            contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: -keyboardHeight + spotterHeigh, right: 0)
            reviewSuperView.frame = reviewSuperView.frame.inset(by: contentInsets!)
            self.keyboardHeightOldValue = 0
            print("⌨️ will hide")
        } else if notification.name == UIResponder.keyboardWillChangeFrameNotification {
            if self.keyboardHeightOldValue == 0 {
                contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - spotterHeigh, right: 0)
                reviewSuperView.frame = reviewSuperView.frame.inset(by: contentInsets!)
                self.keyboardHeightOldValue = keyboardHeight
                print("⌨️ will add \(keyboardHeight)")
            } else if self.keyboardHeightOldValue == keyboardHeight {
                print("⌨️ no need change")
            } else if self.keyboardHeightOldValue < keyboardHeight {
                let differenceHeight = keyboardHeight - self.keyboardHeightOldValue
                contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: differenceHeight, right: 0)
                reviewSuperView.frame = reviewSuperView.frame.inset(by: contentInsets!)
                self.keyboardHeightOldValue = keyboardHeight
                print("⌨️ will change view for \(differenceHeight)")
            } else if self.keyboardHeightOldValue > keyboardHeight {
                let differenceHeight = self.keyboardHeightOldValue - keyboardHeight
                contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: -differenceHeight, right: 0)
                reviewSuperView.frame = reviewSuperView.frame.inset(by: contentInsets!)
                self.keyboardHeightOldValue = keyboardHeight
                print("⌨️ will change view for -\(differenceHeight)")
            }
        }
        print("⌨️ Keyboard Height Now => \(self.keyboardHeightOldValue)")
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - IBAction
    @IBAction func closeButton() {
        didPressedCloseButton?()
    }
    
    @IBAction func sendReviewButtonAction() {
        print("sendReviewButton")
        if let text = reviewTextField.text, text.isEmpty {
            UIView.animate(withDuration: 0.5, animations: {
                self.reviewTextField.backgroundColor = .systemRed
            }) { _ in
                self.reviewTextField.backgroundColor = .white
            }
            
            print("reviewTextField isEmpty")
        } else if let text = reviewTextField.text, !text.isEmpty{
            reviewTextField.text = ""
            print("\(text) is sended")
        }
    }
}

extension ReviewsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.reuseID, for: indexPath) as! ReviewsTableViewCell
        cell.fillData(review: reviews[indexPath.row])
        return cell
    }
}
