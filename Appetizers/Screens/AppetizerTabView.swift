//
//  AppetizerTabView.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import SwiftUI

struct AppetizerTabView: View {
    @EnvironmentObject private var order: Order

    var body: some View {
        TabView {
            AppetizerListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "bag")
                }
                .badge(order.items.count)
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
        .tint(.brandPrimary)
    }
}

#Preview {
    AppetizerTabView()
}
