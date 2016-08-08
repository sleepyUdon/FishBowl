//
//  DefaultTableViewCell.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-06-25.
//  Copyright (c) 2015 Adam Dahan. All rights reserved.
//

import UIKit

public struct DefaultOptions {
    public struct ImageView {
        public struct Padding {
            public static let Vertical = CGFloat(10.0)
            public static let Horizontal = CGFloat(10.0)
        }
    }
    public struct Label {
        public struct Padding {
            public static let Vertical = CGFloat(10.0)
            public static let Horizontal = CGFloat(10.0)
        }
    }
}

public class DefaultTableViewCell: UITableViewCell {
    public lazy var defaultImageView: UIImageView = UIImageView()
    public lazy var defaultLabel: UILabel = UILabel()
    
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
        prepareDefaultImageView()
        prepareDefaultLabel()
    }
    
    /*
    @name   layoutSubviews
    */
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutDefaultImageView()
        layoutDefaultLabel()
    }
    
    /*
    @name   prepareDefaultImageView
    */
    public func prepareDefaultImageView() {
        defaultImageView.backgroundColor = UIColor.yellowColor()
        defaultImageView.clipsToBounds = true
        contentView.addSubview(defaultImageView)
    }
    
    /*
    @name   prepareDefaultLabel
    */
    public func prepareDefaultLabel() {
        defaultLabel.font = UIFont.systemFontOfSize(12.0)
        defaultLabel.text = "Devhub"
        defaultLabel.textColor = UIColor.blackColor()
        defaultLabel.textAlignment = .Left
        addSubview(defaultLabel)
    }
    
    /*
    @name   layoutDefaultImageView
    */
    public func layoutDefaultImageView() {
        let x = CGFloat(20.0)
        let y = CGFloat(DefaultOptions.ImageView.Padding.Vertical)
        let w = CGFloat(contentView.bounds.size.height - (DefaultOptions.ImageView.Padding.Vertical * 2))
        let h = w
        defaultImageView.frame = CGRect(x: x, y: y, width: w, height: h)
       
        // FIX ME: Make dynamic
        defaultImageView.layer.cornerRadius = w / 2
    }
    
    public func layoutDefaultLabel() {
        let x = CGRectGetMaxX(defaultImageView.frame) + DefaultOptions.Label.Padding.Horizontal
        let y = (contentView.bounds.size.height / 2) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        defaultLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
}
