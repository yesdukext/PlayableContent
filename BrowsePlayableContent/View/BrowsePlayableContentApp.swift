//
//  Created by Yves Dukuze on 05/09/2024.
//

import SwiftUI

@main
struct BrowsePlayableContentApp: App {
    
    private let apiService = NetworkService()
    private let coordinator: AppCoordinator
    
    init(){
        self.coordinator = AppCoordinator(apiService: apiService)
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
