//
//  StationsView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 06/09/2024.
//

import SwiftUI

struct StationsView: View {
    
    @StateObject private var viewModel = StationsViewModel()
    
    var body: some View {
        
        NavigationView {
            
            if viewModel.isLoading {
                ProgressView("Loading Stations...")
            } else {
                List(viewModel.playableItems) { item in
                    HStack {
                        AsyncImage(url: URL(string: item.imageURL ?? "")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.stationName)
                                .font(.subheadline)
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
                .navigationTitle("BBC National Station")
            }
        }
        .onAppear {
            viewModel.loadStations()
        }
    }
}

#Preview {
    StationsView()
}
