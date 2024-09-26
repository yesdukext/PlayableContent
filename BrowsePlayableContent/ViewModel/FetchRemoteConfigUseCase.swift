//
//  FetchRemoteConfigUseCase.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 23/09/2024.
//


protocol FetchConfigUseCase {
    
    func execute() async -> Result<ConfigResponse, Error>
    
}

class FetchConfigUseCaseImpl: FetchConfigUseCase {
    
    private let repository: RemoteConfigRepository
    
    init(repository: RemoteConfigRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<ConfigResponse, Error> {
        do {
            let response = try await repository.fetchConfig()
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
}
