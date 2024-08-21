//
//  AccountView.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var viewModel = AccountViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section("Personal info") {
                    TextField("First Name", text: $viewModel.user.firstName)
                    TextField("Last Name", text: $viewModel.user.lastName)
                    TextField("Email", text: $viewModel.user.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    DatePicker("Birthday", selection: $viewModel.user.birth, displayedComponents: .date)
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
        }
    }
}

#Preview {
    AccountView()
}
