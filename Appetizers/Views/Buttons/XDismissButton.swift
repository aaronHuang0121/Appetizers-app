//
//  XDismissButton.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/21.
//

import SwiftUI

struct XDismissButton: View {
    let action: () -> Void
    var body: some View {
        Button(
            action: action,
            label: {
                ZStack {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.white)
                        .opacity(0.6)
                    
                    Image(systemName: "xmark")
                        .imageScale(.small)
                        .frame(width: 44, height: 44)
                        .foregroundStyle(.black)
                }
            }
        )
    }
}

#Preview {
    XDismissButton(action: {})
}
