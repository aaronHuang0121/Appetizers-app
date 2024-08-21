//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import Foundation

final class AppetizerListViewModel: ObservableObject {
    @Published var appetizers: [Appetizer] = []
    @Published var isLoading: Bool = false
    @Published var selectedAppetizer: Appetizer? = nil

    func getAppetizers() -> Void {
        isLoading = true
        NetworkManager.share.getAppetizers { response in
            DispatchQueue.main.async {
                self.isLoading = false
                switch response {
                case .success(let appetizers):
                    self.appetizers = appetizers.request
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func onCloseDetailView() -> Void {
        self.selectedAppetizer = nil
    }
}
