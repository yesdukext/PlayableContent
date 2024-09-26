//
//  RemoteConfigRepo.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 23/09/2024.
//

import Foundation

protocol RemoteConfigRepository {
    
    func fetchConfig() async throws -> ConfigResponse
    
}

class RemoteConfigRepositoryImpl: RemoteConfigRepository {
    
    private let networkService: RemoteConfigNetworkService
    
    init(networkService: RemoteConfigNetworkService) {
        self.networkService = networkService
    }
    
    func fetchConfig() async throws -> ConfigResponse {
        return try await networkService.fetchConfiguration()
    }
}
