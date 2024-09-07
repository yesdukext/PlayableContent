//
//  ErrorView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 07/09/2024.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let onDismiss: () -> Void
    
    var body: some View {
        VStack {
            Text("Error")
                .font(.title)
                .padding()
            
            Text(message)
                .font(.body)
                .padding()
            
            Button(action: onDismiss) {
                Text("Dismiss")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(9)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 9)
        .padding()
    }
}
