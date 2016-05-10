//
//  FeedPhotoTableViewCell.swift
//  Feedworthy
//
//  Created by Vincent Moore on 5/7/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit

class FeedPhotoTableViewCell: FeedTableViewCell {
    
    internal var imageMedia = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Keep autolayout from placing constraints
        imageMedia.translatesAutoresizingMaskIntoConstraints = false
        
        // Image styling
        imageMedia.contentMode = .ScaleAspectFit
        
        // Placing image at the bottom of the stackview
        stackViewContainer.addArrangedSubview(imageMedia)
        
        // Constraint placement
        imageMedia.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(stackViewContainer)
        }
        
        // Styling
        imageMedia.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        imageMedia.layer.shadowOpacity = 0.2
        
        // CALayer Extension
        imageMedia.addBorder(edges: .Top, colour: UIColor.lightGrayColor(), thickness: 0.5)
    }
    
    // Not implemented for xibs
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMediaHeight(height: CGFloat) {
        imageMedia.snp_remakeConstraints(closure: { (make) in
            make.height.equalTo(height).priority(999)
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageMedia.image = nil
    }

}
