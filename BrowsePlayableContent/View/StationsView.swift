//
//  Created by Yves Dukuze on 06/09/2024.
//






import SwiftUI
import Combine

struct StationsView: View {
    @ObservedObject var viewModel: StationsViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.stations, id: \.id) { station in
                HStack {
                    CachedAsyncImage(url: URL(string: station.imageURL))
                    
                    VStack(alignment: .leading) {
                        Text(station.titles.primary)
        
                        Text(station.urn)
                        
                        Text("Static Content")
       
                    }
                }
            }
            .navigationTitle("BBC Stations")
            .sheet(item: $viewModel.error) { error in
                ErrorView(message: error.message, onDismiss: {viewModel.error = nil})
            }
        }
    }
}










//import SwiftUI
//import Combine
//
//struct StationsView: View {
//    @ObservedObject var viewModel: StationsViewModel
//    
//    var body: some View {
//        NavigationView {
//            List(viewModel.stations, id: \.id) { station in
//                HStack {
//                    CachedAsyncImage(url: URL(string: station.imageURL))
//                        .accessibility(hidden: true)
//                    
//                    VStack(alignment: .leading) {
//                        Text(station.titles.primary)
//                            .font(.title2)
//                            .accessibilityLabel("Station Title")
//                            .accessibilityHint("Current playing :")
//                        
//                        Text(station.urn)
//                            .font(.body)
//                            .foregroundColor(.gray)
//                            .accessibilityLabel("urn")
//                            .accessibilityHint("urn description ")
//                    }
//                    .accessibilityElement(children: .combine)
//                }
//                .accessibilityElement(children: .ignore)
//                .accessibilityLabel("Station with title \(station.titles.primary), currently playing: \(station.urn.stringValue)")
//            }
//            .navigationTitle("BBC Stations")
//            .alert(item: $viewModel.error) { error in
//                Alert(title: Text("Error"), message: Text(error.localizedDescription))
//            }
//        }
//    }
//}
