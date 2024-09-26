//
//  WelcomeView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 19/09/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    
    private let apiService: NetworkService
    let appConfigRepo = AppConfigRepository()
    
    init(apiService: NetworkService){
        self.apiService = apiService
    }
    
    var body: some View {
        
        TabView {
            let repository = StationRepImpl(networkService: apiService)
            let viewModel = StationsViewModel(repository: repository)
            
            let networkService = RemoteConfigNetworkServiceImpl()
            let remoteConfigRepository = RemoteConfigRepositoryImpl(networkService: networkService)
            let fetchConfigUseCase = FetchConfigUseCaseImpl(repository: remoteConfigRepository)
            let present = ConfigPresenterImpl(fetchConfigUseCase: fetchConfigUseCase)
            
            
            StationsView(viewModel: viewModel)
                .tabItem {
                    Label("Station", systemImage: "play.circle")
                       
                }
            let appConfigViewModel = AppConfigViewModel(repository: appConfigRepo)
            AppConfigView(viewModel: appConfigViewModel)
                .tabItem {
                    Label("KillSwitch", systemImage :"tray.fill")
                }
  
            
//            Text("Remote Config")
            ConfigView(presenter: present)
                .tabItem {
                    Label("Config", systemImage: "wrench.and.screwdriver.fill")
                }
        }.tint(.cyan)
        
    }
}
