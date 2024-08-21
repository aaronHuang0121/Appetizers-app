//
//  Rest.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import Foundation
import os

enum Rest {
    static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Rest")
    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
}

enum RestError: LocalizedError {
    case invalidURL
    case unableToComplete
    case invalidResponse(Int)
    case invalidData
    case unknowError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid Url"
        case .unableToComplete:
            return "Unable to complete"
        case .invalidResponse(let statusCode):
            return "Invalid response with error code: \(statusCode)"
        case .invalidData:
            return "Invalid data"
        case .unknowError(let error):
            return error.localizedDescription
        }
    }
}

protocol RestProtocol {
    func get<R: Decodable, E: Error>(
        endpoint: String
    ) async -> Result<R, E>
}
