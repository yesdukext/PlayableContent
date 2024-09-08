
//  Created by Yves Dukuze on 06/09/2024.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetchStations() -> AnyPublisher<RMSResponse, Error>
}

class NetworkService: NetworkServiceProtocol {
    func fetchStations() -> AnyPublisher<RMSResponse, Error> {
        let url = URL(string: "https://rms.api.bbc.co.uk/v2/experience/inline/stations")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: RMSResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
