//
//  IdentifiableError.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 07/09/2024.
//

import Foundation

struct IdentifiableError: Identifiable {
    let id = UUID()
    let nsError: NSError
    
    var message: String {
        nsError.localizedDescription
    }
}
