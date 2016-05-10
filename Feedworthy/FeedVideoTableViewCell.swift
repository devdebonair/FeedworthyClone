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
    
    internal var videoView = VideoView()
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
