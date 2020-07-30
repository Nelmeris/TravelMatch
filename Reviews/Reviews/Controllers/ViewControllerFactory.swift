//
//  ViewControllerFactory.swift
//  Reviews
//
//  Created by Igor on 24.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

class ViewControllerFactory {
    
    func makeReviewController() -> ReviewsController {
        return UIStoryboard(name: "Reviews", bundle: Bundle(for: ReviewsController.self))
            .instantiateViewController(ReviewsController.self)
    }
}
