//
//  StationsViewModel.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 06/09/2024.
//

import Combine
import CoreData

class StationsViewModel: ObservableObject {
    @Published var playableItems: [PlayableItem] = []
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadStations()
    }
    
    func loadStations() {
        isLoading = true
        
        let cahedItems = CoreDataManager.shared.fetchCachedPlayableItems()
        if cahedItems.isEmpty {
            fetchFromAPI()
        } else {
            self.playableItems = cahedItems
            self.isLoading = false
        }
    }
    
    private func fetchFromAPI() {
        guard let url = URL(string: "https://rms.api.bbc.co.uk/v2/experience/inline/stations") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ApiResponse.self, decoder: JSONDecoder())
            .map { $0.modules.flatMap { $0.playableItems } }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print ("API error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] items in
                self?.playableItems = items
                CoreDataManager.shared.clearCache()
                CoreDataManager.shared.cachePlayableItems(items)
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
}
