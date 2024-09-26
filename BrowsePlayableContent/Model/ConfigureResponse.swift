//
//  ConfigureResponse.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 23/09/2024.
//

import Foundation

struct ConfigResponse: Codable, Equatable {
    let status: KillSwitch
    let rmsConfig: RMSConfig
    
    enum CodingKeys: String, CodingKey {
        case status
        case rmsConfig = "rmsConfig"
    }
}

struct KillSwitch: Codable, Equatable {
    let isOn: Bool
    let title: String
    let message: String
    let linkTitle: String
    let appStoreUrl: String
}

struct RMSConfig: Codable, Equatable {
    let apiKey: String
    let rootUrl: String
}
