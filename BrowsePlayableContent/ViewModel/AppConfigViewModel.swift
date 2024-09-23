//
//  AppConfigViewModel.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 19/09/2024.
//

import Foundation

class AppConfigViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var message: String = ""
    @Published var linkTitle: String = ""
    @Published var linkURL: String = ""
    @Published var isKilled: Bool = false
    
    private let repository: AppConfigRepositoryProtocol
    
    init(repository: AppConfigRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchConfig(version: String) {
        repository.fetchConfig(version: version) { [weak self] result in
            switch result {
            case .success(let config):
                DispatchQueue.main.async {
                    self?.title = config.status.title
                    self?.message = config.status.message
                    self?.linkURL = config.status.linkTitle
                    self?.linkURL = config.status.appStoreUrl
                    self?.isKilled = !config.status.isOn
                }
            case .failure(let error):
                self?.title = "Error"
                self?.message = error.localizedDescription
                print("Error fetching config: \(error)")
            }
        }
    }
}
