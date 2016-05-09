//
//  FeedTableViewCell.swift
//  PeriscopeFeed
//
//  Created by Vincent Moore on 5/2/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import SnapKit

class FeedTableViewCell: UITableViewCell {
    
    internal var stackViewContainer = UIStackView()
    internal var labelContent = UILabel()
    
    internal var labelUsername = UILabel()
    internal var labelCommunityName = UILabel()
    internal var labelTime = UILabel()
    internal var stackViewStats = UIStackView()
    internal var stackViewMetaContainer = UIStackView()
    internal var progressView = UIProgressView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewStats.translatesAutoresizingMaskIntoConstraints = false
        stackViewMetaContainer.translatesAutoresizingMaskIntoConstraints = false
        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        labelCommunityName.translatesAutoresizingMaskIntoConstraints = false
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewSpacing: CGFloat = 8
        stackViewContainer.axis = .Vertical
        stackViewContainer.distribution = .EqualSpacing
        stackViewContainer.spacing = stackViewSpacing
        
        stackViewStats.axis = .Horizontal
        stackViewStats.distribution = .FillProportionally
        
        stackViewMetaContainer.axis = .Vertical
        stackViewMetaContainer.distribution = .EqualSpacing
        stackViewMetaContainer.spacing = stackViewSpacing
        stackViewMetaContainer.layoutMargins.left = 15
        stackViewMetaContainer.layoutMarginsRelativeArrangement = true
        
        let metaFont = UIFont.boldSystemFontOfSize(10)
        let metaColor = UIColor.lightGrayColor()
        labelTime.font = metaFont
        labelCommunityName.font = metaFont
        labelUsername.font = metaFont
        
        labelUsername.textColor = metaColor
        labelCommunityName.textColor = metaColor
        labelTime.textColor = metaColor
        
        labelContent.numberOfLines = 0
        labelContent.lineBreakMode = .ByWordWrapping
        labelContent.font = UIFont.systemFontOfSize(16)
        
        progressView.trackTintColor = metaColor
        progressView.tintColor = UIColor.darkTextColor()
        progressView.alpha = 0.5
        
        contentView.addSubview(stackViewContainer)
        
        stackViewContainer.addArrangedSubview(stackViewMetaContainer)
        
        stackViewMetaContainer.addArrangedSubview(stackViewStats)
        stackViewMetaContainer.addArrangedSubview(progressView)
        stackViewMetaContainer.addArrangedSubview(labelContent)
        
        stackViewStats.addArrangedSubview(labelTime)
        stackViewStats.addArrangedSubview(labelCommunityName)
        stackViewStats.addArrangedSubview(labelUsername)
        
        stackViewContainer.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        stackViewMetaContainer.snp_makeConstraints { (make) in
            make.right.top.equalTo(stackViewContainer).priorityHigh()
        }
        
        progressView.snp_makeConstraints { (make) in
            make.height.equalTo(0.7)
        }
        
        labelContent.snp_makeConstraints { (make) in
            make.bottom.right.equalTo(stackViewMetaContainer).priorityRequired()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressView.progress = 0
        progressView.alpha = 0.5
    }
    
}
