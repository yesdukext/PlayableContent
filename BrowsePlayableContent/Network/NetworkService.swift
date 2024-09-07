
//  Created by Yves Dukuze on 06/09/2024.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetchStations() -> AnyPublisher<RMSResponse, Error>
}

class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = URL(string: "https://rms.api.bbc.co.uk/v2/experience/inline/stations")!
    
    func fetchStations() -> AnyPublisher<RMSResponse, Error> {
        URLSession.shared.dataTaskPublisher(for: baseURL)
            .map(\.data)
            .decode(type: RMSResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
