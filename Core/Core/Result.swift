//
//  Result.swift
//  Core
//
//  Created by Maxim Timokhin on 28.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//


import Foundation

public struct CoreError: Error {
    var message = ""

    public init(message: String = "") {
        self.message = message
    }
}

extension CoreError: LocalizedError {
    public var errorDescription: String? {
        return message
    }
}

public enum Result<T> {
    case success(T)
    case failure(Error)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
