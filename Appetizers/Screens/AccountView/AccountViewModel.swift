//
//  AccountViewModel.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/21.
//

import Foundation
import SwiftUI

final class AccountViewModel: ObservableObject {
    @AppStorage("user") private var userData: Data?

    @Published var user: User = .init()
    @Published var showAlert: Bool = false
    @Published var formMessage: FormMessage? = nil

    private var isValidForm: Bool {
        guard !user.firstName.isEmpty, !user.lastName.isEmpty, !user.email.isEmpty else {
            showAlert.toggle()
            formMessage = .invalidForm
            return false
        }
        
        guard user.email.isValidEmail() else {
            showAlert.toggle()
            formMessage = .invalidEmail
            return false
        }
        
        return true
    }

    func saveChanges() -> Void {
        guard isValidForm else { return }

        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            formMessage = .userSaveSuccess
        } catch {
            print(error.localizedDescription)
            formMessage = .invalidUserData
        }
        
        showAlert.toggle()
    }

    func retriveUser() -> Void {
        guard let userData else { return }

        do {
            user = try JSONDecoder().decode(User.self, from: userData)
        } catch {
            formMessage = .invalidUserData
            showAlert.toggle()
        }
    }
}

extension AccountViewModel {
    enum FormMessage: LocalizedError {
        case invalidForm
        case invalidEmail
        case userSaveSuccess
        case invalidUserData
        
        var errorDescription: String? {
            switch self {
            case .invalidForm:
                return "Please ensure all fields in the form have been filled out."
            case .invalidEmail:
                return "Please ensure your email is correct."
            case .userSaveSuccess:
                return "Your profile information was successfully saved."
            case .invalidUserData:
                return "There was an error saving or retrieving your profile."
            }
        }
    }
}
