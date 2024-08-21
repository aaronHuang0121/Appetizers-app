//
//  Order.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/21.
//

import Foundation

final class Order: ObservableObject {
    @Published var items: [Appetizer] = []

    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    func add(_ appetizer: Appetizer) -> Void {
        self.items.append(appetizer)
    }

    func delete(at atOffsets: IndexSet) -> Void {
        self.items.remove(atOffsets: atOffsets)
    }
}
