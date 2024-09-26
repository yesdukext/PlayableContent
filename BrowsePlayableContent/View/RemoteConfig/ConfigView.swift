//
//  ConfigView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 23/09/2024.
//

import SwiftUI

struct ConfigView: View {
    
    @StateObject private var presenter: ConfigPresenterImpl
    
    init(presenter: ConfigPresenterImpl) {
        _presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if presenter.isLoading {
                    LoadingView()
                } else if let errorMessage = presenter.errorMessage {
                    RemoteConfigErrorView(errorMessage: errorMessage, retryAction: {
                        presenter.fetchConfig()
                    })
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 18) {
                            if let killSwitch = presenter.killSwitch {
                                KillSwitchView(killSwitch: killSwitch)
                            }
                            
                            if let apiKey = presenter.rmsApiKey, let rootUrl = presenter.rmsBaseUrl {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("RMS Configuration")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 5)
                                
                                    InfoRowView(label: "API Key", value: apiKey)
                                    
                                    InfoRowView(label: "Root URL", value: rootUrl)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            } else {
                                Text("No data available")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                presenter.fetchConfig()
            }
        }
    }
}
