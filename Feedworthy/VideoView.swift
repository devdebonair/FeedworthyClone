//
//  VideoView.swift
//  PeriscopeFeed
//
//  Created by Vincent Moore on 5/9/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

/*
    Needed to create a custom view for the video player.
    This allowed the video layer to resize based on constraints
    during the layoutSubviews function call.
 */


import UIKit
import AVFoundation

class VideoView: UIView {

    private var _url: String?
    private var _playerLayer: AVPlayerLayer
    internal var _player: AVPlayer
    
    internal var player: AVPlayer {
        return _player
    }
    
    init(frame: CGRect = CGRectZero, url: String? = nil) {
        _url = url
        
        if let url = _url, loadedUrl = NSURL(string: url) {
            _player = AVPlayer(URL: loadedUrl)
        } else {
            _player = AVPlayer()
        }
        
        _playerLayer = AVPlayerLayer(player: _player)
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        
        super.init(frame: frame)
        
        layer.addSublayer(_playerLayer)
    }
    
    // Not implemented for xibs
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func layerClass() -> AnyClass {
        return AVPlayerLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _playerLayer.frame = self.bounds
    }
}
