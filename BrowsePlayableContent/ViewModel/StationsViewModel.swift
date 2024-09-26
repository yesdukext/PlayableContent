//
//  Created by Yves Dukuze on 06/09/2024.
//

import Combine
import SwiftUI

final class StationsViewModel: ObservableObject {
    
    @Published var stations: [PlayableItem] = []
    @Published var error: IdentifiableError?
    
    private let repository: StationRepo
    private var cancellable = Set<AnyCancellable>()
        
    init(repository: StationRepo) {
        self.repository = repository
        fetchStations()
    }
    
    func fetchStations() {
        repository.getStations()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = IdentifiableError(nsError: error as NSError)
                }
            }, receiveValue: {[weak self] stations in
                self?.stations = stations
            })
            .store(in: &cancellable)
    }
    
    func fetchJWT(for serviceId: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://rms.api.bbc.co.uk/v2/sign/token/\(serviceId)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
          
            guard let data = data,
                  let tokenResponse = try? JSONDecoder().decode(JWTResponse.self, from: data) else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode token response"])))
                return
            }
            completion(.success(tokenResponse.token))
        }.resume()
    }
}
