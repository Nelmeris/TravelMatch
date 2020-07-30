//
//  ViewControllerFactory.swift
//  Pic
//
//  Created by Igor on 21.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

class ViewControllerFactory {
    
    func makePicController() -> PicController {
        return UIStoryboard(name: "Pic", bundle: Bundle(for: PicController.self))
            .instantiateViewController(PicController.self)
    }
}

