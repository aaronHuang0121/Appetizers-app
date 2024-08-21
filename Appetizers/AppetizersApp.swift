//
//  AppetizersApp.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import SwiftUI

@main
struct AppetizersApp: App {
    var order = Order()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(order)
        }
    }
}
