//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import Foundation
import UIKit

final class NetworkManager: ObservableObject, RestProtocol {
    static let share = NetworkManager()
    private let session: URLSession
    let imageSession: URLSession

    private init() {
        self.imageSession = .imageSession
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10   // 10s
        self.session = URLSession(configuration: config)
    }
    
    func request<R: Decodable>(url urlString: String) async throws -> R {
        guard let url = URL(string: Rest.baseURL + urlString) else {
            throw RestError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RestError.invalidResponse(0)
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw RestError.invalidResponse(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(R.self, from: data)
        } catch {
            throw RestError.invalidData
        }
    }

    func get<R: Decodable, E: Error>(endpoint: String) async -> Result<R, E> {
        do {
            let result: R = try await request(url: endpoint)
            return .success(result)
        } catch {
            Rest.logger.error("\(error.localizedDescription)")
            if let clientError = error as? E {
                return .failure(clientError)
            }
            return .failure(RestError.unknowError(error) as! E)
        }
    }

    func downloadImage(url: URL?) async throws -> UIImage? {
        guard let url else {
            return nil
        }
    
        let urlRequest = URLRequest(url: url)
        if let data = imageSession.configuration.urlCache?.cachedResponse(for: urlRequest)?.data,
            let uiImage = UIImage(data: data) {
            return uiImage
        }
        
        let (data, response) = try await imageSession.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode, let uiImage = UIImage(data: data) else {
            throw RestError.invalidData
        }
        return uiImage
    }
}

extension URLSession {
    static let imageSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = .imageCache
        return .init(configuration: config)
    }()
}

extension URLCache {
    static let imageCache = URLCache(
        memoryCapacity: 20 * 1024 * 1024,
        diskCapacity: 30 * 1024 * 1024
    )
}
