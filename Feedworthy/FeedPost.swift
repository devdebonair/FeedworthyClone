//
//  FeedPost.swift
//  PeriscopeFeed
//
//  Created by Vincent Moore on 5/2/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

class FeedPost {
    enum MediaType: Int {
        case Image = 0
        case Video = 1
    }
    
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