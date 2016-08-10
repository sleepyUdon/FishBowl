//
//  EventDetailTableViewCell.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material


public class ContactsTableViewCell: UITableViewCell {
    public lazy var profileView: UIImageView = UIImageView()
    public lazy var nameLabel: UILabel = UILabel()
    public lazy var titleLabel: UILabel = UILabel()
    
    /*
     @name   required initWithCoder
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
     @name   init
     */
    public override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareImageView()
        prepareNameLabel()
        prepareTitleLabel()
    }
    
    /*
     @name   layoutSubviews
     */
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageView()
        layoutNameLabel()
        layoutTitleLabel()
    }
    
    /*
     @name   prepareDefaultImageView
     */
    public func prepareImageView()
 {
        profileView.backgroundColor = UIColor.clearColor()
        profileView.clipsToBounds = true
        contentView.addSubview(profileView)
    }
    
    /*
     @name   prepareDefaultLabel
     */
    public func prepareNameLabel() {
        nameLabel.font = UIFont.systemFontOfSize(12.0)
        nameLabel.text = "VIVIANE CHAN"
        nameLabel.textColor = MaterialColor.black
        nameLabel.textAlignment = .Left
        addSubview(nameLabel)
    }
    
    
    /*
     @name   prepareDefaultDescription
     */
    public func prepareTitleLabel() {
        titleLabel.font = UIFont.systemFontOfSize(12.0)
        titleLabel.text = "iOS Developer"
        titleLabel.textColor = MaterialColor.grey.lighten2
        titleLabel.textAlignment = .Left
        addSubview(titleLabel)
    }
    
    
    /*
     @name   layoutDefaultImageView
     */
    public func layoutImageView() {
        let x = CGFloat(20.0)
        let y = CGFloat(DefaultOptions.ImageView.Padding.Vertical)
        let w = CGFloat(contentView.bounds.size.height - (DefaultOptions.ImageView.Padding.Vertical * 2))
        let h = w
        profileView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        // FIX ME: Make dynamic
        profileView.layer.cornerRadius = w / 2
    }
    
    public func layoutNameLabel() {
        let x = CGRectGetMaxX(profileView.frame) + DefaultOptions.Label.Padding.Horizontal
        let y = (contentView.bounds.size.height / 6) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        nameLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    public func layoutTitleLabel() {
        let x = CGRectGetMaxX(profileView.frame) + DefaultOptions.Label.Padding.Horizontal
        let y = (contentView.bounds.size.height / 2) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
}
