//
//  CachedAsyncImage.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 07/09/2024.
//

import SwiftUI

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

struct CachedAsyncImage: View {
    
    let url: URL?
    @State private var image: UIImage?
    @State private var loading = true
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .accessibility(hidden: true)
                    .accessibilityLabel("Content Image")
                    .accessibilityHint("Shows the image of a playable content")
            } else if loading {
                ProgressView()
                    .frame(maxWidth: 100, maxHeight: 100)
            }
        }
        .onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        guard let url = url else {
            loading = false
            return
        }
        
        let cacheKey = NSString(string: url.absoluteString)
        
        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            self.loading = false
        } else {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let uiImage = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.loading = false
                    }
                    return
                }
                ImageCache.shared.setObject(uiImage, forKey: cacheKey)
                DispatchQueue.main.async {
                    self.image = uiImage
                    self.loading = false
                }
            }.resume()
        }
    }
}
