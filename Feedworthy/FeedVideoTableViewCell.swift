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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        videoView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        videoView.layer.shadowOpacity = 0.2
        videoView.addBorder(edges: .Top, colour: UIColor.lightGrayColor(), thickness: 0.5)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackViewContainer.addArrangedSubview(videoView)
        
        videoView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(stackViewContainer)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        videoView.player.replaceCurrentItemWithPlayerItem(nil)
    }
}
