//
//  EventDetailTableViewCell.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material


public class ParticipantsTableViewCell: UITableViewCell {
    public lazy var profileView: MaterialView = MaterialView()
    public lazy var nameLabel: UILabel = UILabel()
    public lazy var titleLabel: UILabel = UILabel()
    public lazy var addedButton: UIButton = UIButton()
    public lazy var buttonSelected = false
    
    
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
        prepareAddedButton()
    }
    
    /*
     @name   layoutSubviews
     */
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageView()
        layoutNameLabel()
        layoutTitleLabel()
        layoutAddedButton()
    }
    
    /*
     @name   prepareDefaultImageView
     */
    public func prepareImageView()
 {
        profileView.image = UIImage(named: "VivianeChan") //#PASSDATA picture from participants
        profileView.shape = .Circle
        profileView.backgroundColor = UIColor.clearColor()
        profileView.clipsToBounds = true
        contentView.addSubview(profileView)
    }

    
    /*
     @name   prepareDefaultLabel
     */
    public func prepareNameLabel() {
        nameLabel.font = UIFont(name: "Avenir-Heavy", size: 14)
        nameLabel.text = "Viviane Chan" //#PASSDATA name from participants
        nameLabel.textColor = MaterialColor.black
        nameLabel.textAlignment = .Left
        addSubview(nameLabel)
    }
    
    
    /*
     @name   prepareDefaultDescription
     */
    public func prepareTitleLabel() {
        titleLabel.font = UIFont(name: "Avenir", size: 14)
        titleLabel.text = "iOS Developer" //#PASSDATA title from participants
        titleLabel.textColor = MaterialColor.grey.darken2
        titleLabel.textAlignment = .Left
        addSubview(titleLabel)
    }
    
    /*
     @name   prepareDefaultParticipants
     */
    public func prepareAddedButton() {
        addedButton.setImage(UIImage(named: "AddButton"), forState: UIControlState.Normal)
        addedButton.addTarget(self, action: #selector(handleAddedButton), forControlEvents: .TouchUpInside)
        addSubview(addedButton)
    }
    
    
    func handleAddedButton() {
        if (buttonSelected == false) //BUTTONOFF
        {
            addedButton.setImage(UIImage(named: "okButton"),forState:  UIControlState.Normal);
            buttonSelected = true

        }
        else
        {
            addedButton.setImage(UIImage(named: "AddButton"),forState: UIControlState.Normal);
            buttonSelected = false
        }
    }
//        // #SAVETOCOREDATA
//    }

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
        let w = (contentView.bounds.size.width - 120.0)
        let h = CGFloat(30.0)
        nameLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    public func layoutTitleLabel() {
        let x = CGRectGetMaxX(profileView.frame) + DefaultOptions.Label.Padding.Horizontal
        let y = (contentView.bounds.size.height / 2) - (15.0)
        let w = (contentView.bounds.size.width - 120.0)
        let h = CGFloat(30.0)
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func layoutAddedButton() {
        let x = (contentView.bounds.size.width) - (50.0)
        let y = (contentView.bounds.size.height / 2) - (15.0)
        let w = CGFloat(25.0)
        let h = CGFloat(25.0)
        addedButton.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
}
