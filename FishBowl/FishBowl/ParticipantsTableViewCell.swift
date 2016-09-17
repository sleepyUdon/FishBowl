//  ParticipantsTableViewCell.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import UIKit
import Material
import CoreData


open class ParticipantsTableViewCell: UITableViewCell {
    
    lazy var materialView: MaterialView = MaterialView()
    lazy var nameLabel: UILabel = UILabel()
    lazy var titleLabel: UILabel = UILabel()
    lazy var button: MaterialButton = MaterialButton()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCell()
    }
    
    var member : Member! {
        didSet {
            updateCellContent()
        }
    }
    
    fileprivate var buttonSelected:Bool! {
        didSet {
            handleChangeToButtonSelected()
        }
    }
    
    //MARK: Button Event
    func buttonTapped() {
        if ( buttonSelected == false) {
            saveMember()
            button.setTitleColor(MaterialColor.white, for: UIControlState())
            button.setTitle("Added", for: UIControlState())
            button.backgroundColor = MaterialColor.green.base
        }
    }
    
    func saveMember() {
        
        
        if ( buttonSelected == false) //BUTTONOFF
        {
            let context = self.appDelegate.managedObjectContext
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            
            let member : Member = self.member
            
//            user.setValue(member.memberId, forKey: "userID")
//            user.setValue(member.memberName, forKey: "name")
//            user.setValue(member.memberBio, forKey: "title")
//            user.setValue(member.memberCompany, forKey: "company")
//            user.setValue(member.memberEmail, forKey: "email")
//            user.setValue(member.memberPhone, forKey: "phone")
//            user.setValue(member.memberGithub, forKey: "github")
//            user.setValue(member.memberLinkedin, forKey: "linkedin")
//            user.setValue(member.memberImage, forKey: "picture")
//            user.setValue(member.memberNote, forKey: "note")
            
            user.userID = member.memberId
            user.name = member.memberName
            user.title = member.memberBio
            user.company = member.memberCompany
            user.email = member.memberEmail
            user.phone = member.memberPhone
            user.linkedin = member.memberLinkedin
            user.picture = member.memberImage
            user.note = member.memberNote
            
            do {
                //save
                try user.managedObjectContext?.save()
                //try context.save()
                buttonSelected = true
                
            }
            catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
            }
        }
    }
}

extension ParticipantsTableViewCell {

    fileprivate func createCell() {
        // Only called for new cell creation, not cell reuse
        prepareImageView()
        prepareNameLabel()
        prepareTitleLabel()
        setupButton()
    }
    
    public func prepareImageView()
    {
        materialView.image = UIImage(named: "photoplaceholder.png")
        materialView.shape = .circle
        materialView.backgroundColor = UIColor.clear
        materialView.clipsToBounds = true
        contentView.addSubview(materialView)
    }
    
    public func prepareNameLabel() {
        nameLabel.font = Fonts.title
        nameLabel.textColor = Color.greyDark
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        addSubview(nameLabel)
    }
    
    public func prepareTitleLabel() {
        titleLabel.font = Fonts.bodyGrey
        titleLabel.textColor = Color.greyMedium
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
    }
    
    fileprivate func setupButton() {
        addSubview(button)
        button.isSelected = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        print(button)
    }
}

extension ParticipantsTableViewCell {
    // layout code
    /*
     @name   layoutDefaultImageView
     */
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageView()
        layoutAddedButton()
        layoutNameLabel()
        layoutTitleLabel()
    }
    
    /*
     @name   layoutDefaultImageView
     */
    public func layoutImageView() {
        let y = CGFloat(5.0)
        let x = CGFloat(10.0)
        let h = contentView.bounds.size.height - (10.0)
        let w = h
        materialView.frame = CGRect(x: x, y: y, width: w, height: h)
        materialView.layer.cornerRadius = w / 2
    }
    
    public func layoutAddedButton() {
        let h = (contentView.bounds.size.height) - (30.0)
        let w = h * 2.5
        let x = (contentView.bounds.size.width) - w - (15.0)
        let y = CGFloat(15.0)
        button.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func layoutNameLabel() {
        let x = CGFloat(10.0) + (materialView.frame.width) + CGFloat(5.0)
        let y = CGFloat(5.0)
        let w = contentView.bounds.size.width - CGFloat(10.0) - (materialView.frame.width) - CGFloat(5.0) - button.frame.width - CGFloat(10.0)
        let h = CGFloat(50.0)
        nameLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func layoutTitleLabel() {
        let x = CGFloat(10.0) + (materialView.frame.width) + CGFloat(5.0)
        let y = CGFloat(5.0) + (nameLabel.frame.height)
        let w = contentView.bounds.size.width - CGFloat(5.0) + (materialView.frame.width) + CGFloat(5.0) - button.frame.width - CGFloat(5.0)
        let h = (contentView.bounds.size.height - CGFloat(5.0) - CGFloat(5.0))/2
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
}

//MARK: Handle Cell data, Called on creation + reuse
extension ParticipantsTableViewCell {
    
    fileprivate func updateCellContent() {
        
        titleLabel.text = member.memberBio
        nameLabel.text = member.memberName
        //TODO your dataManager should return a Bool here. Send it the memberId and have it search the data store. This violates MVC!
        let setOfIds = settingMemberIds()
        buttonSelected = setOfIds.contains(member.memberId)
        materialView.image = member.memberImage != nil ? UIImage(data: member.memberImage!) : UIImage(named: "photoplaceholder.png")
    }
    
    fileprivate func handleChangeToButtonSelected() {
        button.isEnabled = !buttonSelected
        guard buttonSelected == true else {
            button.setTitleColor(Color.greyMedium, for: UIControlState())
            button.setTitle("Add", for: UIControlState())
            button.backgroundColor = MaterialColor.grey.lighten4
            button.pulseColor = MaterialColor.white
            button.cornerRadius = 5.0
            button.titleLabel!.font = Fonts.bodyGrey
            return
        }
        button.setTitleColor(MaterialColor.white, for: UIControlState())
        button.setTitle("Added", for: UIControlState())
        button.backgroundColor = MaterialColor.green.base
    }
    
    fileprivate func settingMemberIds()->Set<String> {
        let con = DataManager.getMemberFromContacts() as Array<User>
        //print(con)
        var setOfIds: Set<String> = Set()
        for contactObj in con {
            print(contactObj)
            setOfIds.insert(contactObj.userID as String)
        }
        return setOfIds
    }
}
