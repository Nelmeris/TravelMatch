//
//  Authentificatable.swift
//  Auth
//
//  Created by Maxim Timokhin on 28.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

public protocol Authentificatable {
    var id: String {get}
    var name: String {get}
}
