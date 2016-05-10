//
//  FeedVideoTableViewCell.swift
//  PeriscopeFeed
//
//  Created by Vincent Moore on 5/7/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import AVFoundation

class FeedVideoTableViewCell: FeedTableViewCell {
    
    internal let MAX_VOLUME: Float = 1.0
    internal let MIN_VOLUME: Float = 0.0
    internal let MIN_ACCESSORY_ALPHA: CGFloat = 0.2
    internal let MAX_ACCESSORY_ALPHA: CGFloat = 1.0
    
    internal var videoView = VideoView()
    
    internal var volume: Float {
        return videoView.player.volume
    }
    
    // Image that shows a speaker when audio is playing on a video
    internal var accessoryImage = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        // Keep autolayout from placing constraints
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        // Styling
        videoView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        videoView.layer.shadowOpacity = 0.2
        videoView.addBorder(edges: .Top, colour: UIColor.lightGrayColor(), thickness: 0.5)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Place video at bottom of superviews stackview
        stackViewContainer.addArrangedSubview(videoView)
        
        // Constrain video to bottom of stackview
        videoView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(stackViewContainer)
        }
    }
    
    func setMediaHeight(height: CGFloat) {
        videoView.snp_makeConstraints(closure: { (make) in
            make.height.equalTo(height).priority(999)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Decrease volume and fade out accessory view
    func mute() {
        videoView.player.volume = MIN_VOLUME
        UIView.animateWithDuration(0.4, animations: {
            self.accessoryImage.alpha = self.MIN_ACCESSORY_ALPHA
        })
    }
    
    // Increase volume and fade in accessory view
    func unmute() {
        videoView.player.volume = MAX_VOLUME
        UIView.animateWithDuration(0.4, animations: {
            self.accessoryImage.alpha = self.MAX_ACCESSORY_ALPHA
        })
    }
    
    // Pause video and lower opacity of accessory view
    func pause() {
        videoView.player.pause()
        accessoryImage.alpha = MIN_ACCESSORY_ALPHA
    }
    
    // Play video and adjust opacity of accessory view based on volume
    func play(isMuted: Bool = true) {
        videoView.player.play()
        videoView.player.volume = isMuted ? MIN_VOLUME : MAX_VOLUME
        accessoryImage.alpha = isMuted ? MIN_ACCESSORY_ALPHA : MAX_ACCESSORY_ALPHA
    }
    
    // change video in player
    func setVideo(url: NSURL) {
        videoView.player.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: url))
    }
    
    // add image to bottom left corner of player with tint color
    func addAccessoryView(image: UIImage, tintColor: UIColor = UIColor.whiteColor()) {
        accessoryImage.image = image
        accessoryImage.image?.imageWithRenderingMode(.AlwaysTemplate)
        accessoryImage.tintColor = tintColor
        
        videoView.addSubview(accessoryImage)
        
        accessoryImage.snp_makeConstraints { (make) in
            make.left.equalTo(videoView).offset(20)
            make.bottom.equalTo(videoView).offset(-15)
            make.height.width.equalTo(20)
        }
    }
    
    // Default values
    override func prepareForReuse() {
        super.prepareForReuse()
        videoView.player.volume = 0.0
        videoView.player.replaceCurrentItemWithPlayerItem(nil)
        accessoryImage.removeConstraints(accessoryImage.constraints)
        accessoryImage.removeFromSuperview()
    }
}
