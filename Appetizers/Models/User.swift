//
//  User.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/21.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var birth: Date
    var extraNapkins: Bool
    var frequentRefills: Bool

    init(
        firstName: String = "",
        lastName: String = "",
        email: String = "",
        birth: Date = .now,
        extraNapkins: Bool = false,
        frequentRefills: Bool = false
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.birth = birth
        self.extraNapkins = extraNapkins
        self.frequentRefills = frequentRefills
    }
}

extension User {
    static let mock = User(
        firstName: "Aaron",
        lastName: "Huang",
        email: "aaron.huang@mail.com",
        birth: .now,
        extraNapkins: true,
        frequentRefills: true
    )
}
