//
//  AppCoordinator.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 06/09/2024.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    
    @Published var currentView: AnyView = AnyView(StationsView())
    
    func start() {
        currentView = AnyView(StationsView())
    }
}
