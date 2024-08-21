//
//  RemoteImage.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import SwiftUI

struct RemoteImage<Placeholder: View>: View {
    @State private var phase: AsyncImagePhase
    let url: URL?
    let placeholder: () -> Placeholder

    init(
        url: String,
        @ViewBuilder placeholder: @escaping () -> Placeholder = {
            Image("food-placeholder")
                .resizable()
        }
    ) {
        self.url = URL(string: url)
        if let url = self.url {
            if let data = NetworkManager.share.imageSession.configuration.urlCache?.cachedResponse(for: URLRequest(url: url))?.data,
               let uiImage = UIImage(data: data) {
                self._phase = .init(initialValue: .success(Image(uiImage: uiImage)))
            } else {
                self._phase = .init(initialValue: .empty)
            }
        } else {
            self._phase = .init(initialValue: .empty)
        }
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            switch phase {
            case .empty:
                placeholder()
                    .task {
                        await loadImage()
                    }
            case .success(let image):
                image
                    .resizable()
            case .failure:
                placeholder()
            @unknown default:
                Text("There should not show.")
            }
        }
    }
}

extension RemoteImage {
    private func loadImage() async {
        do {
            if let uiImage = try await NetworkManager.share.downloadImage(url: url) {
                phase = .success(Image(uiImage: uiImage))
            } else {
                throw RestError.invalidData
            }
        } catch {
            phase = .failure(error)
        }
    }
}

#Preview {
    RemoteImage(url: "")
}
