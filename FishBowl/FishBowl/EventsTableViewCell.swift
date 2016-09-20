//  EventsTableViewCell.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import UIKit
import Material


public class EventsTableViewCell: UITableViewCell {
    public lazy var defaultImageView: UIImageView = UIImageView()
    public lazy var dateLabel: UILabel = UILabel()
    public lazy var descriptionLabel: UILabel = UILabel()
    public lazy var participantsLabel: UILabel = UILabel()
    public lazy var menumodel: MenuModel = MenuModel()
    
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
        prepareDateLabel()
        prepareDescriptionLabel()
        prepareParticipantsLabel()
    }
    
    /*
    @name   layoutSubviews
    */
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutDateLabel()
        layoutDescriptionLabel()
        layoutParticipantsLabel()
    }
    
    /*
    @name   prepareDefaultLabel (Events Title)
    */
    public func prepareDateLabel() {
        dateLabel.font = Fonts.smallfont
        dateLabel.layer.borderColor = MaterialColor.grey.base.CGColor
        dateLabel.layer.borderWidth = 0.5
        dateLabel.backgroundColor = MaterialColor.grey.lighten3
        dateLabel.textColor = Color.greyMedium
        dateLabel.textAlignment = .Left
        addSubview(dateLabel)
    }
    
    /*
     @name   prepareDefaultDescription (Events Date)
     */
    public func prepareDescriptionLabel() {
        descriptionLabel.font = Fonts.smallfont
        descriptionLabel.textColor = Color.greyDark
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .Left
        addSubview(descriptionLabel)
    }
    
    /*
     @name   prepareDefaultParticipants
     */
    public func prepareParticipantsLabel() {
        participantsLabel.font = Fonts.smallfont
        participantsLabel.textColor = Color.greyMedium
        participantsLabel.textAlignment = .Left
        addSubview(participantsLabel)
    }
    
    
    /*
    @name   layout labels
    */
    public func layoutDateLabel() {
        let x = CGFloat(0.0)
        let y = CGFloat(0.0)
        let w = contentView.frame.width 
        let h = CGFloat(25.0)
        dateLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func layoutDescriptionLabel() {
        let x = CGFloat(20.0)
        let y = CGFloat(30.0)
        let w = contentView.frame.width - (40.0)
        let h = CGFloat(45.0)
        descriptionLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func layoutParticipantsLabel() {
        let x = CGFloat(20.0)
        let y = CGFloat(75)
        let w = contentView.frame.width - (40.0)
        let h = CGFloat(25.0)
        participantsLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }

}
