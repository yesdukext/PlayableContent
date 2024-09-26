//
//  ConfigPresenter.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 23/09/2024.
//

import Foundation

protocol ConfigPresenter: ObservableObject {
    
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var killSwitch: KillSwitch? { get }
    var rmsApiKey: String? { get }
    var rmsBaseUrl: String? { get }
    
    func fetchConfig()
}

class ConfigPresenterImpl: ConfigPresenter {
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = nil
    @Published private(set) var killSwitch: KillSwitch? = nil
    @Published private(set) var rmsApiKey: String? = nil
    @Published private(set) var rmsBaseUrl: String? = nil
    
    private let fetchConfigUseCase: FetchConfigUseCase
    
    init(fetchConfigUseCase: FetchConfigUseCase) {
        self.fetchConfigUseCase = fetchConfigUseCase
    }
    
    func fetchConfig() {
        Task {
            self.isLoading = true
            let result = await fetchConfigUseCase.execute()
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let configResponse):
                    self.killSwitch = configResponse.status
                    self.rmsApiKey = configResponse.rmsConfig.apiKey
                    self.rmsBaseUrl = configResponse.rmsConfig.rootUrl
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
