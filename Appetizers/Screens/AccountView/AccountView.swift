//
//  AccountView.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var viewModel = AccountViewModel()
    @FocusState private var focusState: FormTextField?

    var body: some View {
        NavigationView {
            Form {
                Section("Personal info") {
                    TextField("First Name", text: $viewModel.user.firstName)
                        .focused($focusState, equals: .firstName)
                        .onSubmit { focusState = .lastName }
                        .submitLabel(.next)

                    TextField("Last Name", text: $viewModel.user.lastName)
                        .focused($focusState, equals: .lastName)
                        .onSubmit { focusState = .email }
                        .submitLabel(.next)

                    TextField("Email", text: $viewModel.user.email)
                        .focused($focusState, equals: .email)
                        .onSubmit { focusState = nil }
                        .submitLabel(.continue)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
    
                    DatePicker(
                        "Birthday",
                        selection: $viewModel.user.birth,
                        in: Date().oneHundredTenYearsAgo...Date().eighteenYearsAgo,
                        displayedComponents: .date
                    )

                    Button(
                        action: viewModel.saveChanges,
                        label: {
                            Text("Save Changes")
                        }
                    )
                }
                
                Section("Request") {
                    Toggle("Extra Napkins", isOn: $viewModel.user.extraNapkins)
                    Toggle("Frequent Refills", isOn: $viewModel.user.frequentRefills)
                }
                .tint(.brandPrimary)
            }
            .navigationTitle("Account")
            .onAppear(perform: viewModel.retriveUser)
            .alert(isPresented: $viewModel.showAlert, error: viewModel.formMessage) {
                Button("OK", role: .none, action: {})
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Dismiss", action: { focusState = nil })
                }
            }
        }
    }
}

extension AccountView {
    enum FormTextField: Hashable {
        case firstName
        case lastName
        case email
    }
}

#Preview {
    AccountView()
}
