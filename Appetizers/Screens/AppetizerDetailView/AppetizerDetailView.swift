//
//  AppetizerDetailView.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import SwiftUI

struct AppetizerDetailView: View {
    let appetizer: Appetizer
    let onClose: () -> Void

    var body: some View {
        VStack {
            RemoteImage(url: appetizer.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 225)
            
            Text(appetizer.name)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(appetizer.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack(spacing: 40) {
                InfoView(title: "Calories", value: "\(appetizer.calories)")
                InfoView(title: "Carbs", value: "\(appetizer.carbs)")
                InfoView(title: "Protein", value: "\(appetizer.protein)")
            }
            
            Spacer()
            
            Button(
                action: {},
                label: {
                    appetizer.price.currency
                    + Text(" - Add to Order")
                }
            )
            .buttonStyle(StandardButtonStyle())
            .padding(.bottom, 30)
        }
        .frame(width: 300, height: 525)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(radius: 40)
        }
        .overlay(
            alignment: .topTrailing,
            content: {
                XDismissButton(action: onClose)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension AppetizerDetailView {
    @ViewBuilder
    private func InfoView(title: String, value: String) -> some View {
        VStack(spacing: 5) {
            Text(title)
                .bold()
                .font(.caption)
            
            Text(value)
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}

#Preview {
    AppetizerDetailView(appetizer: .mock, onClose: {})
}
