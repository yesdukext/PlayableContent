
//  Created by Yves Dukuze on 06/09/2024.


import Combine
import CoreData

protocol StationRepo {
    func getStations() -> AnyPublisher<[PlayableItem], Error>
}

class StationRepImpl: StationRepo {
    
    private let apiService: NetworkService
    private var cachedStations: [PlayableItem]?
    
    init(networkService: NetworkService) {
        self.apiService = networkService
    }
    
    func getStations() -> AnyPublisher<[PlayableItem], Error> {
        if let cached = cachedStations {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return apiService.fetchStations()
            .tryMap { response -> [PlayableItem] in
                guard let module = response.data.first(where: {$0.id == "national_and_regional_stations"}) else {
                    throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No promoted stations found"])
                }
                self.cachedStations = module.data
                return self.cachedStations ?? []
            }
            .eraseToAnyPublisher()
    }
}
