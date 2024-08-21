//
//  AppetizerListCell.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import SwiftUI

struct AppetizerListCell: View {
    let appetizer: Appetizer

    var body: some View {
        HStack {
            RemoteImage(url: appetizer.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .id(appetizer.id)
            
            VStack(alignment: .leading) {
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.medium)
                
                appetizer.price.currency
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            .padding(.leading)
            
            Spacer()
        }
    }
}

#Preview {
    AppetizerListCell(appetizer: .mock)
}
