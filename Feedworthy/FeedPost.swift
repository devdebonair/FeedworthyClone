//
//  FeedPost.swift
//  PeriscopeFeed
//
//  Created by Vincent Moore on 5/2/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

class FeedPost {
    
    // Easy way to designate whether post type is a photo or video
    enum MediaType: Int {
        case Image = 0
        case Video = 1
    }
    
    // Simple structure to encapsulate Media data without creating another class
    struct Media {
        var type: MediaType
        var url: String
        var width: Int
        var height: Int
    }
    
    var username: String
    var media: Media?
    var community: String
    var time: String
    var content: String?
    
    init(username: String, community: String, time: String, media: Media? = nil, content: String? = nil) {
        self.username = username
        self.community = community
        self.time = time
        self.media = media
        self.content = content
    }
}