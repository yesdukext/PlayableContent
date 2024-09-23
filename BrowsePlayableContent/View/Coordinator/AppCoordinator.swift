
//  Created by Yves Dukuze on 06/09/2024.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    
    private let apiService: NetworkService
    
    init(apiService: NetworkService){
        self.apiService = apiService
    }
    
    func start() -> some View {
//        let repository = StationRepImpl(networkService: apiService)
//        let viewModel = StationsViewModel(repository: repository)
//        return StationsView(viewModel: viewModel)
        return WelcomeView(apiService: apiService)
        
    }
}
