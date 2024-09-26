
// Created by Yves Dukuze on 06/09/2024.


import SwiftUI
import Combine

struct StationsView: View {
    @ObservedObject var viewModel: StationsViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.stations, id: \.id) { station in
                NavigationLink(destination: StationDetailView(station: station, viewModel: viewModel)) {
                    HStack {
                        CachedAsyncImage(url: URL(string: station.formattedImageURL))
                        
                        VStack(alignment: .leading) {
                            Text(station.titles.primary)
                                .font(.title2)
                                .accessibilityLabel(station.titles.primary)
            
                            Text(station.synopses.short)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                                .accessibilityLabel(station.synopses.short)
           
                        }
                    }
                }
            }
            .navigationTitle("BBC playable content").accessibility(hidden: true)
            .sheet(item: $viewModel.error) { error in
                ErrorView(message: error.message, onDismiss: {viewModel.error = nil})
            }
        }
    }
}
