//
//  SMPView.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 22/09/2024.
//

import SwiftUI
import SMP


import SwiftUI
struct SMPView: UIViewRepresentable {
    
    var smpVideoView: UIView?
    
    func makeUIView(context: Context) -> UIView {
        return SMPUIView(videoView: smpVideoView)
    }
    
    func updateUIView(_ uiView:  UIView, context: Context) {
        guard let uiView = uiView as? SMPUIView else {return}
        uiView.videoView = smpVideoView
    }
}
