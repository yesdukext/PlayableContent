//
//  RemoteConfigView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 19/09/2024.
//
import SwiftUI

struct AppConfigView: View {
    
    @ObservedObject var viewModel: AppConfigViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .padding()
            
            Text(viewModel.message)
                .padding()
            
            if viewModel.isKilled {
                Button(action:  {
                    if let url = URL(string: viewModel.linkURL) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text(viewModel.linkTitle)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
            
            HStack {
                Button("Load Live Config") {
                    viewModel.fetchConfig(version: "2.3.0")
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Load Killed Config") {
                    viewModel.fetchConfig(version: "1.15.0")
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
    }
}
