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
    case invalidResponse
    case invalidData
}

protocol RestProtocol {
    func get<R: Decodable, E: Error>(
        endpoint: String,
        completed: @escaping (Result<R, E>) -> Void
    ) -> Void
}
