//
//  Created by Yves Dukuze on 06/09/2024.
//

import Combine
import SwiftUI

final class StationsViewModel: ObservableObject {
    
    @Published var stations: [RMSData] = []
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
}
