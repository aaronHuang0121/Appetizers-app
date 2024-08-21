//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import Foundation

@MainActor
final class AppetizerListViewModel: ObservableObject {
    @Published var appetizers: [Appetizer] = []
    @Published var isLoading: Bool = false
    @Published var selectedAppetizer: Appetizer? = nil

    func getAppetizers() {
        isLoading = true
        Task {
            switch await NetworkManager.share.getAppetizers() {
            case .success(let appetizers):
                self.appetizers = appetizers.request
                isLoading = false
            case .failure(let error):
                print(error.localizedDescription)
                isLoading = false
            }
        }
    }
    
    func onCloseDetailView() -> Void {
        self.selectedAppetizer = nil
    }
}
