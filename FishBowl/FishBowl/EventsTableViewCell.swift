//  EventsTableViewCell.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import UIKit
import Material

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
        dateLabel.text?.uppercaseString
        dateLabel.numberOfLines = 0
        dateLabel.textColor = Color.greyDark
        dateLabel.textAlignment = .Left
        addSubview(dateLabel)
    }
    
    /*
     @name   prepareDefaultDescription (Events Date)
     */
    public func prepareDescriptionLabel() {
        descriptionLabel.font = Fonts.smallfont
        descriptionLabel.backgroundColor = MaterialColor.grey.lighten2
        descriptionLabel.textColor = Color.greyDark
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
        let x = CGFloat(20.0)
        let y = CGFloat(20.0)
        let w = contentView.frame.width - (40.0)
        let h = CGFloat(60.0)
        dateLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func layoutDescriptionLabel() {
        let x = CGFloat(20.0)
        let y = CGFloat(0.0)
        let w = contentView.frame.width
        let h = CGFloat(20.0)
        descriptionLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func layoutParticipantsLabel() {
        let x = CGFloat(20.0)
        let y = CGFloat(80.0)
        let w = contentView.frame.width - (40.0)
        let h = CGFloat(20.0)
        participantsLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }

}
