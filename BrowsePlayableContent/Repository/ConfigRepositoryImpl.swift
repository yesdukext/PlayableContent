//
//  ConfigRepositoryImpl.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 19/09/2024.
//

import Foundation

protocol AppConfigRepositoryProtocol {
    func fetchConfig(version: String, completion: @escaping (Result<AppConfig, Error>) -> Void)
}

class AppConfigRepository: AppConfigRepositoryProtocol {
    
    func fetchConfig(version: String, completion: @escaping (Result<AppConfig, Error>) -> Void) {
        let urlString = "https://sounds-mobile-config.files.bbci.co.uk/ios/\(version)/config.json"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do {
                let config = try JSONDecoder().decode(AppConfig.self, from: data)
                completion(.success(config))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
