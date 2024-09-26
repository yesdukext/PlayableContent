//
//  InfoRowView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 23/09/2024.
//

import SwiftUI

struct InfoRowView: View {
    
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(label + ":")
                .font(.caption)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 3)
    }
}
