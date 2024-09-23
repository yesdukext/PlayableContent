//
//  MyAvStatisticsConsumer.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 22/09/2024.
//

import SMP

class MyAvStatisticsConsumer: NSObject, BBCSMPAVStatisticsConsumer {
    
    // TODO: Implement the necessary methods, can leave them empty for now
    
    func trackAVSessionStart(itemMetadata: BBCSMPItemMetadata) {
        
    }
    
    func trackAVFullMediaLength(lengthInSeconds mediaLengthInSeconds: Int) {
        
    }
    
    func trackAVPlayback(currentLocation: Int, customParameters: [AnyHashable : Any]?) {
        
    }
    
    func trackAVPlaying(subtitlesActive: Bool, playlistTime: Int, assetTime: Int, currentLocation: Int, assetDuration: Int) {
        
    }
    
    func trackAVBuffer(playlistTime: Int, assetTime: Int, currentLocation: Int) {
        
    }
    
    func trackAVPause(playlistTime: Int, assetTime: Int, currentLocation: Int) {
        
    }
    
    func trackAVResume(playlistTime: Int, assetTime: Int, currentLocation: Int) {
        
    }
    
    func trackAVScrub(from fromTime: Int, to toTime: Int) {
        
    }
    
    func trackAVEnd(subtitlesActive: Bool, playlistTime: Int, assetTime: Int, assetDuration: Int, wasNatural: Bool, customParameters: [AnyHashable : Any]?) {
        
    }
    
    func trackAVSubtitlesEnabled(_ subtitlesEnabled: Bool) {
        
    }
    
    func trackAVPlayerSizeChange(_ playerSize: CGSize) {
        
    }
    
    func trackAVError(_ errorString: String, playlistTime: Int, assetTime: Int, currentLocation: Int, customParameters: [AnyHashable : Any]?) {
        
    }
    
}
