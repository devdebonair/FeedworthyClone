//
//  FeedPhotoTableViewCell.swift
//  PeriscopeFeed
//
//  Created by Vincent Moore on 5/7/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit

class FeedPhotoTableViewCell: FeedTableViewCell {
    
    internal var imageMedia = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageMedia.translatesAutoresizingMaskIntoConstraints = false
        imageMedia.contentMode = .ScaleAspectFit
        stackViewContainer.addArrangedSubview(imageMedia)
        imageMedia.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(stackViewContainer)
        }
        
        imageMedia.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        imageMedia.layer.shadowOpacity = 0.2
        imageMedia.addBorder(edges: .Top, colour: UIColor.lightGrayColor(), thickness: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageMedia.image = nil

    }

}
