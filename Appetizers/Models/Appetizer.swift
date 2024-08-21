//
//  Appetizer.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import Foundation

struct Appetizer: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let calories: Int
    let protein: Int
    let carbs: Int
}

extension Appetizer {
    static let mock = Appetizer(
        id: 0001,
        name: "Test Appetizer",
        description: "This is the description for my appetizer. It's yummy.",
        price: 9.99,
        imageURL: "",
        calories: 99,
        protein: 99,
        carbs: 99
    )

    static let appetizers: [Appetizer] = [
        Appetizer(
            id: 0001,
            name: "Test Appetizer One",
            description: "This is the description for my appetizer. It's yummy.",
            price: 9.99,
            imageURL: "",
            calories: 99,
            protein: 99,
            carbs: 99
        ),
        Appetizer(
            id: 0002,
            name: "Test Appetizer Two",
            description: "This is the description for my appetizer. It's yummy.",
            price: 9.99,
            imageURL: "",
            calories: 99,
            protein: 99,
            carbs: 99
        ),
        Appetizer(
            id: 0003,
            name: "Test Appetizer Three",
            description: "This is the description for my appetizer. It's yummy.",
            price: 9.99,
            imageURL: "",
            calories: 99,
            protein: 99,
            carbs: 99
        ),
    ]
}
