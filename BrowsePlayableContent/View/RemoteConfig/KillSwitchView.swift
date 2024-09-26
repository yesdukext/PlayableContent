//
//  KillSwitchView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 23/09/2024.
//

import SwiftUI

struct KillSwitchView: View {
    
    let killSwitch: KillSwitch
    
    var body: some View {
        
        VStack {
            Text(killSwitch.title)
                .font(.headline)
                .padding()
            
            Text(killSwitch.message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                if let url = URL(string: killSwitch.appStoreUrl) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text(killSwitch.linkTitle)
                    .font(.headline)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            .padding()
        }
    }
}

