//
//  Created by Yves Dukuze on 06/09/2024.
//

import Combine
import CoreData

protocol StationRepo {
    func getStations() -> AnyPublisher<[RMSData], Error>
}

class StationRepImpl: StationRepo {
    
    private let apiService: NetworkService
    private var cachedStations: [RMSData]?
    
    init(networkService: NetworkService) {
        self.apiService = networkService
    }
    
    func getStations() -> AnyPublisher<[RMSData], Error> {
        if let cached = cachedStations {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return apiService.fetchStations()
            .map { response in
                self.cachedStations = response.modules.flatMap { $0.displayables }
                return self.cachedStations ?? []
            }
            .eraseToAnyPublisher()
    }
}
