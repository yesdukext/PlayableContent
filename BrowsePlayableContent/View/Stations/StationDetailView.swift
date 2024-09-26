//
//  StationDetailView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 22/09/2024.


import SwiftUI
import SMP

struct StationDetailView: View {
    
    let station: PlayableItem
    
    @State var smpVideoView: UIView?
    @State var isPlaying = false
    
    @ObservedObject var viewModel: StationsViewModel
    @State private var jwtToken: String?
    
    
    var body: some View {
        VStack(spacing: 15) {
            
            Text(station.network.shortTitle)
                .font(.title3)
                .bold()
                .foregroundStyle(.red)
                .accessibilityLabel(station.network.shortTitle)
            
            Text(station.titles.primary)
                .font(.subheadline)
                .accessibilityLabel(station.titles.primary)
            
            
            CachedAsyncImage(url: URL(string: station.formattedImageURL))
                .frame(width: 150, height: 150)

            Text(station.synopses.short)
                .font(.body)
                .foregroundColor(.gray)
                .accessibilityLabel(station.synopses.short)
            
            ZStack {
                Color.black.frame(width: 300, height: 150)
                SMPView(smpVideoView: smpVideoView)
                    .frame(height: 150)
                
                Button(isPlaying ? "" : "Listen Live") {
                    if isPlaying {
                        stopPlayback()
                    } else {
                        fetchJWTAndPlay(for: station)
                    }
                }.foregroundColor(.white)
                    .bold()
                    .font(.headline)
            }
        
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.automatic)
    }
    
    private func playStation(with station: PlayableItem) {
        guard let jwtToken = jwtToken else {return }
        
        var builder = BBCSMPPlayerBuilder()
        builder = builder.withInterruptionEndedBehaviour(.autoresume)
        let smp = builder.build()
        
        let authProvider = MediaSelectorAuthenticationProvider(jwtToken: jwtToken)
        
        let playerItemProvider = MediaSelectorItemProviderBuilder(VPID: station.id, mediaSet: "mobile-phone-main", AVType: .audio, streamType: .simulcast, avStatisticsConsumer: MyAvStatisticsConsumer())
            .withAuthenticationProvider(authProvider)
            .buildItemProvider()
        
        smp.playerItemProvider = playerItemProvider
        smp.play()
        isPlaying = true
        
        smpVideoView = smp.buildUserInterface().buildView()
    }
    
    private func stopPlayback() {
        smpVideoView = nil
        isPlaying = false
    }
    
    private func fetchJWTAndPlay(for station: PlayableItem) {
        
        let serviceId = station.id
        
        viewModel.fetchJWT(for: serviceId) { result in
            switch result {
            case.success(let jwtToken):
                DispatchQueue.main.async {
                    self.jwtToken = jwtToken
                    self.playStation(with: station)
                }
            case.failure(let error):
                print("Failed to get JWT: \(error)")
                
            }
        }
    }
}
