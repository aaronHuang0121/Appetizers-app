//
//  GetAppetizers.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import Foundation

extension Rest {
    enum GetAppetizers {
        struct Response: Decodable {
            let request: [Appetizer]
        }
    }
}

extension RestProtocol {
    func getAppetizers(completed: @escaping (Result<Rest.GetAppetizers.Response, RestError>) -> Void) -> Void {
        get(
            endpoint: "appetizers", completed: completed
        )
    }
}
