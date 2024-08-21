//
//  OrderView.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject private var order: Order

    var body: some View {
        NavigationView {
            VStack {
                if order.items.isEmpty {
                    EmptyState(
                        image: "empty-order",
                        message: "You have no items in your order.\nPlease add an appetizer!"
                    )
                    .padding(.bottom, 50)
                } else {
                    List {
                        ForEach(order.items) { appetizer in
                            AppetizerListCell(appetizer: appetizer)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: order.delete)
                    }
                    .listStyle(.plain)
                    
                    Button(
                        action: {},
                        label: {
                            order.totalPrice.currency
                                + Text(" - Place orders")
                        }
                    )
                    .buttonStyle(StandardButtonStyle())
                    .padding(.bottom)
                }
            }
            .navigationTitle("Orders")
        }
    }
}

#Preview {
    OrderView()
        .environmentObject(Order())
}
