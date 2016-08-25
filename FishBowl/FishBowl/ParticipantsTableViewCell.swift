//
//  EventDetailTableViewCell.swift
//  FishBowl
//
//  Created by Viviane Chan, Yevhen Kim on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material
import CoreData


public class ParticipantsTableViewCell: UITableViewCell {
    
    
    lazy var profileView: MaterialView = MaterialView()
    lazy var nameLabel: UILabel = UILabel()
    lazy var titleLabel: UILabel = UILabel()
    var button: MaterialButton!
    var dataManager: DataManager!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // get button state from data
    var buttonSelected:Bool! {
        didSet {
            if buttonSelected == true {
                button.enabled = false
            }
        }
    }
    
    // passing member
    
    //    var member : Member = Member(memberId: "someMemberId", memberName: "someMember", memberImage: nil)
    var member : Member! {
        didSet {
            populateCell()
        }
    }
    
    private func populateCell() {
        titleLabel.text = member.memberBio
        nameLabel.text = member.memberName
        if DataManager.getMemberIDsFromContacts().contains(member.memberId) {
            buttonSelected = true
        }
        guard let imageData = member.memberImage else {
            profileView.image = UIImage(named: "photoplaceholder.png")
            return
        }
        profileView.image = UIImage(data: imageData)
    }
    
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
        setupView()
    }
    
    private func setupView() {
        // calls into extension

        prepareImageView()
        prepareNameLabel()
        prepareTitleLabel()
        createButton()
        configureButtonForSelectedState()
    }
    
    
    private func createButton() {
        button = nil
        button = MaterialButton()
        addSubview(button)
        buttonSelected = false
        button.addTarget(self, action: #selector(handleAddedButton), forControlEvents: .TouchUpInside)
        configureButtonForSelectedState()
    }
    
    
    func handleAddedButton(button:UIButton) {
        let context = self.appDelegate.managedObjectContext
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as! User
        
        if ( buttonSelected == false) //BUTTONOFF
        {
            buttonSelected = true
            //
            let member : Member = self.member
            
            user.userID = member.memberId
            user.name = member.memberName
            user.title = member.memberBio
            user.company = member.memberCompany
            user.email = member.memberEmail
            
            user.phone = member.memberPhone
            user.github = member.memberGithub
            user.linkedin = member.memberLinkedin
            user.picture = member.memberImage
            
            do {
                //save
                try user.managedObjectContext?.save()
                
            } catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
            }

        }
     
        configureButtonForSelectedState()
    }
    
}

extension ParticipantsTableViewCell {
    // View Setup
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
        profileView.image = UIImage(named: "photoplaceholder.png") //#PASSDATA picture from participants
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
        //nameLabel.text = "Viviane Chan" //#PASSDATA name from participants
        nameLabel.textColor = Color.greyDark
        nameLabel.textAlignment = .Left
        nameLabel.numberOfLines = 0
        addSubview(nameLabel)
    }
    
    
    /*
     @name   prepareDefaultDescription
     */
    public func prepareTitleLabel() {
        titleLabel.font = Fonts.bodyGrey
        titleLabel.textColor = Color.greyMedium
        titleLabel.textAlignment = .Left
        addSubview(titleLabel)
    }
    
    /*
     @name   prepareDefaultParticipants
     */
    public func configureButtonForSelectedState() {
        
        // check button state and assign corresponding color
        
        if buttonSelected == true {
            button.setTitleColor(MaterialColor.white, forState: .Normal)
            button.setTitle("Added", forState: UIControlState.Normal)
            button.backgroundColor = MaterialColor.green.base
        } else {
            button.setTitleColor(Color.greyMedium, forState: .Normal)
            button.setTitle("Add", forState: UIControlState.Normal)
            button.backgroundColor = MaterialColor.grey.lighten4
            button.pulseColor = MaterialColor.white
            button.cornerRadius = 5.0
            button.titleLabel!.font = Fonts.bodyGrey
        }
    }
    
}

extension ParticipantsTableViewCell {
    // layout code
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
        let w = h * 2.5
        let x = (contentView.bounds.size.width) - w - (15.0)
        let y = CGFloat(15.0)
        button.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func layoutNameLabel() {
        let x = CGFloat(10.0) + (profileView.frame.width) + CGFloat(5.0)
        let y = CGFloat(5.0)
        let w = contentView.bounds.size.width - CGFloat(10.0) - (profileView.frame.width) - CGFloat(5.0) - button.frame.width - CGFloat(10.0)
        let h = CGFloat(50.0)
        nameLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    public func layoutTitleLabel() {
        let x = CGFloat(10.0) + (profileView.frame.width) + CGFloat(5.0)
        let y = CGFloat(5.0) + (nameLabel.frame.height)
        let w = contentView.bounds.size.width - CGFloat(5.0) + (profileView.frame.width) + CGFloat(5.0) - button.frame.width - CGFloat(5.0)
        let h = (contentView.bounds.size.height - CGFloat(5.0) - CGFloat(5.0))/2
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
}