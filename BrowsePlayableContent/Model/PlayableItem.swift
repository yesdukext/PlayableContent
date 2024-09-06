//
//  PlayableItem.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 06/09/2024.
//

import Foundation
import SwiftData

struct PlayableItem: Identifiable, Codable {
    let id: String
    let title: String
    let imageURL: String
    let stationName: String
}

struct Module: Codable {
    let title: String
    let playableItems: [PlayableItem]
}

struct ApiResponse: Codable {
    let modules: [Module]
}
