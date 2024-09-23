//
//  RMSAuthenticator.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 22/09/2024.
//

import Foundation
import SMP

class RMSAuthenticator {
    
    func fetchJWTToken(for serviceID: String, completion: @escaping (String?) -> Void){
        let url = URL(string: "https://rms.api.bbc.co.uk/v2/sign/token/\(serviceID)")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let jwt = String(data: data, encoding: .utf8)
            print("==========================> JWT: \(jwt ?? "")")
            completion(jwt)
        }.resume()
    }
}
