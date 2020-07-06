//
//  LocalsService.swift
//  Locals
//
//  Created by Maxim Timokhin on 06.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Core

public typealias LocalsSearchCompletion = (_ result: Result<[Local]>) -> Void

public protocol LocalsService {
    
    func search(
        request: SearchRequest?,
        completion: @escaping LocalsSearchCompletion
    )
    
}
