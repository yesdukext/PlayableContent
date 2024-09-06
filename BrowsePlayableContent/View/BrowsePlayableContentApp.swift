//
//  BrowsePlayableContentApp.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 05/09/2024.
//

import SwiftUI

@main
struct BrowsePlayableContentApp: App {
    
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            coordinator.currentView
        }
    }
}
