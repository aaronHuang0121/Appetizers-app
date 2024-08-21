//
//  EmptyState.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/21.
//

import SwiftUI

struct EmptyState: View {
    let image: String
    let message: String

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            
            Text(message)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding()
        }
    }
}

#Preview {
    EmptyState(image: "empty-order", message: "You have no items in your order.\nPlease add an appetizer!")
}
