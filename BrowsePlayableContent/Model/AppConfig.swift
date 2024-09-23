//
//  AppConfig.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 19/09/2024.
//

import Foundation

struct AppConfig: Decodable {
    
    struct Status: Decodable {
        let isOn: Bool
        let title: String
        let message: String
        let linkTitle: String
        let appStoreUrl: String
    }
    
    struct RMSConfig: Decodable {
        let apiKey: String
        let rootUrl: String
    }
    
    struct PlaybackConfig: Decodable {
        
        struct MediaSelectorConfig: Decodable {
            let baseUrl: String
        }
        let mediaSelectorConfig: MediaSelectorConfig
    }
    
    let status: Status
    let rmsConfig: RMSConfig
    let playbackConfig: PlaybackConfig
}

