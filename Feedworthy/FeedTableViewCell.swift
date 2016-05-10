//
//  FeedTableViewCell.swift
//  Feedworthy
//
//  Created by Vincent Moore on 5/2/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import SnapKit

class FeedTableViewCell: UITableViewCell {
    
    // Stackviews
    internal var stackViewContainer = UIStackView()
    internal var stackViewStats = UIStackView()
    internal var stackViewMetaContainer = UIStackView()
    
    // Labels
    internal var labelTime = UILabel()
    internal var labelCommunityName = UILabel()
    internal var labelUsername = UILabel()
    internal var labelContent = UILabel()
    
    // Progress bar
    internal var progressView = UIProgressView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Keep autolayout from making its own constraints
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewStats.translatesAutoresizingMaskIntoConstraints = false
        stackViewMetaContainer.translatesAutoresizingMaskIntoConstraints = false
        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        labelCommunityName.translatesAutoresizingMaskIntoConstraints = false
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        
        // Container that holds all content in cell
        let stackViewSpacing: CGFloat = 8
        stackViewContainer.axis = .Vertical
        stackViewContainer.distribution = .EqualSpacing
        stackViewContainer.spacing = stackViewSpacing
        
        // Container that holds user data - community name, username, time posted
        stackViewStats.axis = .Horizontal
        stackViewStats.distribution = .FillProportionally
        
        // Container that holds all text in cell
        stackViewMetaContainer.axis = .Vertical
        stackViewMetaContainer.distribution = .EqualSpacing
        stackViewMetaContainer.spacing = stackViewSpacing
        stackViewMetaContainer.layoutMargins.left = 15
        stackViewMetaContainer.layoutMarginsRelativeArrangement = true
        
        // Label Styling
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
        
        // Progress Bar Styling
        progressView.trackTintColor = metaColor
        progressView.tintColor = UIColor.darkTextColor()
        progressView.alpha = 0.5
        
        contentView.addSubview(stackViewContainer)
        
        // Content structuring
        stackViewContainer.addArrangedSubview(stackViewMetaContainer)
        
        stackViewMetaContainer.addArrangedSubview(stackViewStats)
        stackViewMetaContainer.addArrangedSubview(progressView)
        stackViewMetaContainer.addArrangedSubview(labelContent)
        
        stackViewStats.addArrangedSubview(labelTime)
        stackViewStats.addArrangedSubview(labelCommunityName)
        stackViewStats.addArrangedSubview(labelUsername)
        
        // Contstraints placement
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
    
    // not implemented for xibs
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Default values
        progressView.progress = 0
        progressView.alpha = 0.5
    }
    
    func buildCell(time: String, communityName: String, username: String, content: String?) {
        labelContent.text = content
        labelTime.text = time
        labelUsername.text = username
        labelCommunityName.text = communityName
    }
    
    func setProgress(progress: Float) {
        progressView.setProgress(progress, animated: true)
        progressView.alpha = 1.0
    }
    
    func resetProgress() {
        progressView.setProgress(0.0, animated: false)
        progressView.alpha = 0.5
    }
    
}
