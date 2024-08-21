//
//  AppetizerListView.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import SwiftUI

struct AppetizerListView: View {
    @StateObject private var viewModel = AppetizerListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.appetizers) { appetizer in
                        AppetizerListCell(appetizer: appetizer)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                viewModel.selectedAppetizer = appetizer
                            }
                    }
                }
                .listStyle(.plain)
                
                if viewModel.isLoading {
                    ProgressView()
                        .controlSize(.large)
                        .padding()
                }
            }
            .navigationTitle("Appetizer View")
        }
        .onAppear(perform: viewModel.getAppetizers)
        .popup(
            item: $viewModel.selectedAppetizer
        ) { appetizer in
            AppetizerDetailView(
                appetizer: appetizer,
                onClose: viewModel.onCloseDetailView
            )
        }
    }
}

#Preview {
    AppetizerListView()
}
