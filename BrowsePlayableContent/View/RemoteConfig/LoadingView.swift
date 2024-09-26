//
//  LoadingView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 23/09/2024.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
                .padding()
            
            Text("Loading...")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground).opacity(0.8))
    }
}

