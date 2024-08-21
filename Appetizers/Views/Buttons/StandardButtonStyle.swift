//
//  StandardButtonStyle.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/21.
//

import SwiftUI

struct StandardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.semibold)
            .lineLimit(1)
            .minimumScaleFactor(0.6)
            .padding()
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.brandPrimary)
            )
    }
}

#Preview {
    Button(
        action: {}, 
        label: {
            Text("Long Long Long Long Long Long Long Long Button")
        }
    )
    .buttonStyle(StandardButtonStyle())
}
