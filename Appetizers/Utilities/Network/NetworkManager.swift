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
    let imageSession: URLSession

    private init() {
        self.imageSession = .imageSession
    }
    
    func request<R: Decodable, E: Error>(
        url urlString: String,
        completed: @escaping (Result<R, E>) -> Void
    ) {
        guard let url = URL(string: Rest.baseURL + urlString) else {
            completed(.failure(RestError.invalidURL as! E))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard error == nil else {
                completed(.failure(RestError.unableToComplete as! E))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completed(.failure(RestError.invalidResponse as! E))
                return
            }
            
            guard let data else {
                completed(.failure(RestError.invalidData as! E))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let res = try decoder.decode(R.self, from: data)
                completed(.success(res))
            } catch {
                completed(.failure(RestError.invalidData as! E))
            }
        }
        
        task.resume()
    }
    
    func get<R, E>(endpoint: String, completed: @escaping (Result<R, E>) -> Void) where R : Decodable, E : Error {
        request(url: endpoint, completed: completed)
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
