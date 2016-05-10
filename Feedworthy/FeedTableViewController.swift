//
//  FeedTableViewController.swift
//  Feedworthy
//
//  Created by Vincent Moore on 5/2/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation

class FeedTableViewController: UITableViewController {
    
    let FEED_CELL_IDENTIFIER = "FEED_TABLE_CELL",
        FEED_CELL_IDENTIFIER_PHOTO = "FEED_TABLE_CELL_PHOTO",
        FEED_CELL_IDENTIFIER_VIDEO = "FEED_TABLE_CELL_VIDEO"
    
    let MIN_HEADER_HEIGHT: CGFloat = 0,
        MAX_HEADER_HEIGHT: CGFloat = 60
    
    // Reference to currently playing video cell
    var currentVideo: FeedVideoTableViewCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Group style TableView to remove sticky headers
        tableView = UITableView(frame: self.tableView.frame, style: .Grouped)
        
        // Three different table cells
        tableView.registerClass(FeedTableViewCell.self, forCellReuseIdentifier: FEED_CELL_IDENTIFIER)
        tableView.registerClass(FeedPhotoTableViewCell.self, forCellReuseIdentifier: FEED_CELL_IDENTIFIER_PHOTO)
        tableView.registerClass(FeedVideoTableViewCell.self, forCellReuseIdentifier: FEED_CELL_IDENTIFIER_VIDEO)
        
        // Delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // Row Heights
        tableView.estimatedRowHeight = 440
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // TableView Styling
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.whiteColor()
        
        // Remove extra lines at bottom of TableView
        tableView.tableFooterView = UIView()
    }

    // Each cell belongs to one section for easy spacing
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return FeedData.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = FeedData[indexPath.section]
    
        // Get appropriate TableCell type for post media type
        var identifier = FEED_CELL_IDENTIFIER
        if let media = post.media {
            if media.type == .Image {
                 identifier = FEED_CELL_IDENTIFIER_PHOTO
            }
            if media.type == .Video {
                identifier = FEED_CELL_IDENTIFIER_VIDEO
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        
        // Configure post meta data for cell
        if let cell = cell as? FeedTableViewCell {
            cell.buildCell(post.time.uppercaseString, communityName: post.community.uppercaseString, username: post.username.uppercaseString, content: post.content)
        }
        
        if let media = post.media, url = NSURL(string: media.url) {
            
            // Get the aspect ratio of video or image to resize media to fit TableView
            let aspectWidth = UIScreen.mainScreen().bounds.width / CGFloat(media.width)
            let aspectHeight = UIScreen.mainScreen().bounds.height / CGFloat(media.height)
            let ratio = min(aspectWidth, aspectHeight)
            let newHeight = CGFloat(media.height) * ratio

            if let cell = cell as? FeedPhotoTableViewCell where media.type == .Image {
                
                // Give photo a constraint with resized height
                cell.setMediaHeight(newHeight)
                
                // Download image from url and place in cell image view - Track Progress
                cell.imageMedia.kf_setImageWithURL(url, placeholderImage: UIImage(), optionsInfo: [.Transition(ImageTransition.Fade(1))], progressBlock: { (receivedSize, totalSize) in
                    let progress = Float(receivedSize / totalSize)
                    cell.setProgress(progress)
                }, completionHandler: { _ in
                    cell.resetProgress()
                })
            }
            
            if let cell = cell as? FeedVideoTableViewCell where media.type == .Video {
                
                // Add URL to new Table Cell
                cell.setVideo(url)
                
                // Constrain video view to resized height
                cell.setMediaHeight(newHeight)
                
                if let image = UIImage(named: "unmute") {
                    cell.addAccessoryView(image)
                }
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? FeedVideoTableViewCell {
            cell.play()
        }
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? FeedVideoTableViewCell {
            cell.pause()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = FeedData[indexPath.section]
        
        if let media = post.media where media.type == .Video {
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if let cell = cell as? FeedVideoTableViewCell {
                
                // Check if video is muted and toggle volume/icon
                if cell.volume < cell.MAX_VOLUME {
                    cell.unmute()
                    
                    // mute any video currently playing
                    if cell != currentVideo {
                        currentVideo?.mute()
                    }
                    
                    currentVideo = cell
                    
                } else {
                    cell.mute()
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? MIN_HEADER_HEIGHT : MAX_HEADER_HEIGHT
    }
}