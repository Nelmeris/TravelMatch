//
//  QuestionsViewController.swift
//  Questions
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class QuestionsViewController: BaseViewController {

    // MARK: - Input
    
    var question: Question? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    
    var onContinueClicked: (([Answer]) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var continueButton: UIButton?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout?.estimatedItemSize = .zero
        collectionView?.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    // MARK: - Actions
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        guard let answers = question?.answers,
            let selectedIndexPaths = collectionView?.indexPathsForSelectedItems
            else { return }
                
        let selectedAnswers = selectedIndexPaths.map { answers[$0.row] }
        onContinueClicked?(selectedAnswers)
    }
    
    // MARK: - Update view
    
    private func updateView() {
        guard let question = question else { return }
        
        titleLabel?.text = question.title
        descriptionLabel?.text = question.description
        
        collectionView?.reloadData()
    }

}

// MARK: - UICollectionViewDataSource
extension QuestionsViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return question?.answers.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            forClass: QuestionCollectionViewCell.self,
            for: indexPath
        )
        
        if let answer = question?.answers[indexPath.row] {
            cell.configure(with: answer)
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension QuestionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        continueButton?.isEnabled = (collectionView.indexPathsForSelectedItems?.count ?? 0) > 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        continueButton?.isEnabled = (collectionView.indexPathsForSelectedItems?.count ?? 0) > 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension QuestionsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
}
