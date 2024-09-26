//
//  ErrorView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 23/09/2024.
//

import SwiftUI

struct RemoteConfigErrorView: View {
    let errorMessage: String
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
            
            Text(errorMessage)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    Text("Retry")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background()
                        .cornerRadius(9)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground).opacity(0.9))
    }
}

