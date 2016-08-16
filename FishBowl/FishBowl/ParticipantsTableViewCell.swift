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
    public lazy var addedButton: MaterialButton = MaterialButton()
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
        layoutAddedButton()
        layoutNameLabel()
        layoutTitleLabel()
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
        nameLabel.font = Fonts.title
        nameLabel.text = "Viviane Chan" //#PASSDATA name from participants
        nameLabel.textColor = Color.greyDark
        nameLabel.textAlignment = .Left
        addSubview(nameLabel)
    }
    
    
    /*
     @name   prepareDefaultDescription
     */
    public func prepareTitleLabel() {
        titleLabel.font = Fonts.bodyGrey
        titleLabel.text = "iOS Developer" //#PASSDATA title from participants
        titleLabel.textColor = Color.greyMedium
        titleLabel.textAlignment = .Left
        addSubview(titleLabel)
    }
    
    /*
     @name   prepareDefaultParticipants
     */
    public func prepareAddedButton() {
        addedButton.setTitle("Add", forState: UIControlState.Normal)
        addedButton.setTitleColor(Color.greyMedium, forState: .Normal)
        addedButton.backgroundColor = MaterialColor.grey.lighten4
        addedButton.pulseColor = MaterialColor.white
        addedButton.cornerRadius = 5.0
        addedButton.titleLabel!.font = Fonts.bodyGrey
        addedButton.addTarget(self, action: #selector(handleAddedButton), forControlEvents: .TouchUpInside)
        addSubview(addedButton)
    }
    
    
    func handleAddedButton() {
        if (buttonSelected == false) //BUTTONOFF
        {
            addedButton.setTitleColor(MaterialColor.white, forState: .Normal)
            addedButton.setTitle("Added", forState: UIControlState.Normal)
            addedButton.backgroundColor = MaterialColor.green.base
            buttonSelected = true
        }
        else
        {
            addedButton.setTitleColor(Color.greyMedium, forState: .Normal)
            addedButton.setTitle("Add", forState: UIControlState.Normal)
            addedButton.backgroundColor = MaterialColor.grey.lighten4
            buttonSelected = false
            
        }
    }
//        // #SAVETOCOREDATA
//    }

    /*
     @name   layoutDefaultImageView
     */
    public func layoutImageView() {
        let y = CGFloat(5.0)
        let x = CGFloat(10.0)
        let h = contentView.bounds.size.height - (10.0)
        let w = h
        profileView.frame = CGRect(x: x, y: y, width: w, height: h)
        profileView.layer.cornerRadius = w / 2
    }
    
    
    public func layoutAddedButton() {
        let h = (contentView.bounds.size.height) - (30.0)
        let w = h * 3
        let x = (contentView.bounds.size.width) - w - (15.0)
        let y = CGFloat(15.0)
        addedButton.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func layoutNameLabel() {
        let x = CGFloat(10.0) + (profileView.frame.width) + CGFloat(5.0)
        let y = CGFloat(5.0)
        let w = contentView.bounds.size.width - CGFloat(5.0) + (profileView.frame.width) + CGFloat(5.0) - addedButton.frame.width - CGFloat(5.0)
        let h = (contentView.bounds.size.height - CGFloat(5.0) - CGFloat(5.0))/2
        nameLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    public func layoutTitleLabel() {
        let x = CGFloat(10.0) + (profileView.frame.width) + CGFloat(5.0)
        let y = CGFloat(5.0) + (nameLabel.frame.height)
        let w = contentView.bounds.size.width - CGFloat(5.0) + (profileView.frame.width) + CGFloat(5.0) - addedButton.frame.width - CGFloat(5.0)
        let h = (contentView.bounds.size.height - CGFloat(5.0) - CGFloat(5.0))/2
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
}
