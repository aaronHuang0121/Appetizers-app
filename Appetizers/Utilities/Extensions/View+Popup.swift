//
//  View+Popup.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/21.
//

import Foundation
import SwiftUI

extension View {
    func popup<T: Equatable, Content: View>(
        item: Binding<T?>,
        @ViewBuilder content: @escaping (T) -> Content
    ) -> some View {
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .disabled(item.wrappedValue != nil)
            .overlay(
                content: {
                    GeometryReader { _ in
                        if let unwrappedItem = item.wrappedValue {
                            Rectangle()
                                .foregroundStyle(.ultraThinMaterial)
                                .ignoresSafeArea()
                                .gesture(
                                    TapGesture()
                                        .onEnded({
                                            item.wrappedValue = nil
                                        })
                                )
                            content(unwrappedItem)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                }
            )
            .animation(.default, value: item.wrappedValue)
    }
}
