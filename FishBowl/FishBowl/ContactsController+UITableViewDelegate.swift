//
//  MenuViewController+UITableViewDelegate.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-11-02.
//  Copyright © 2015 Adam Dahan. All rights reserved.
//

import UIKit
import Material

extension ContactsViewController: UITableViewDelegate {

    /*
    @name   required didSelectRowAtIndexPath
    */
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let destination = EventDetailViewController()
//        navigationController?.pushViewController(destination, animated: true)
//
//        // didSelect
        prepareLargeCardViewExample(indexPath)

    }

    private func prepareLargeCardViewExample(indexPath:NSIndexPath) {
        
            let users = ContactsModel().getUsers()
            let user = users[indexPath.row]
        
            let cardView: MaterialPulseView = MaterialPulseView(frame: CGRectMake(16, 100, view.bounds.width - 32, 400))
            cardView.pulseColor = MaterialColor.blueGrey.base
            cardView.depth = .Depth1
            view.addSubview(cardView)
            
//            let leftImageView: MaterialView = MaterialView()
//            leftImageView.image = image
//            leftImageView.contentsGravityPreset = .ResizeAspectFill
//            cardView.addSubview(leftImageView)
        
        

            let topImageView: MaterialView = MaterialView()
            topImageView.contentsGravityPreset = .ResizeAspectFill
            cardView.addSubview(topImageView)
        
            let profileView: MaterialView = MaterialView()
            profileView.image = UIImage(data: user.image!)
            profileView.contentsGravityPreset = .ResizeAspectFill
            profileView.shape = .Circle
            topImageView.addSubview(profileView)
        
            let contentView: MaterialView = MaterialView()
            contentView.backgroundColor = MaterialColor.clear
            cardView.addSubview(contentView)
            
            let nameLabel: UILabel = UILabel()
            nameLabel.text = user.name
            nameLabel.textAlignment = .Center
            nameLabel.font = UIFont(name: "Avenir-Heavy", size: 15)
            nameLabel.textColor = MaterialColor.black
            contentView.addSubview(nameLabel)
        
            let titleLabel: UILabel = UILabel()
            titleLabel.text = user.title
            titleLabel.textAlignment = .Center
            titleLabel.font = UIFont(name: "Avenir", size: 15)
            titleLabel.textColor = MaterialColor.grey.darken2
            contentView.addSubview(titleLabel)
        
            let companyLabel: UILabel = UILabel()
            companyLabel.font = UIFont(name: "Avenir", size: 15)
            companyLabel.text = user.company
            companyLabel.textAlignment = .Center
            companyLabel.textColor = MaterialColor.grey.darken4
            contentView.addSubview(companyLabel)
        
            let mailImage: UIImage? = UIImage(named: "mail")?.imageWithRenderingMode(.AlwaysTemplate)
            let mailButton: IconButton = IconButton()
            mailButton.pulseColor = MaterialColor.blueGrey.darken4
            mailButton.tintColor = MaterialColor.blueGrey.darken4
            mailButton.backgroundColor = MaterialColor.grey.lighten3
            mailButton.setImage(mailImage, forState: .Normal)
            mailButton.setImage(mailImage, forState: .Highlighted)
            contentView.addSubview(mailButton)
        
            let messageImage: UIImage? = UIImage(named: "message")?.imageWithRenderingMode(.AlwaysTemplate)
            let messageButton: IconButton = IconButton()
            messageButton.pulseColor = MaterialColor.blueGrey.darken4
            messageButton.tintColor = MaterialColor.blueGrey.darken4
//            messageButton.backgroundColor = MaterialColor.grey.lighten3
            messageButton.setImage(messageImage, forState: .Normal)
            messageButton.setImage(messageImage, forState: .Highlighted)
            contentView.addSubview(messageButton)


            let phoneImage: UIImage? = UIImage(named:"phone.png")?.imageWithRenderingMode(.AlwaysTemplate)
            let phoneButton: IconButton = IconButton()
            phoneButton.pulseColor = MaterialColor.blueGrey.darken4
            phoneButton.tintColor = MaterialColor.blueGrey.darken4
            phoneButton.backgroundColor = MaterialColor.grey.lighten3
            phoneButton.setImage(phoneImage, forState: .Normal)
            phoneButton.setImage(phoneImage, forState: .Highlighted)
            contentView.addSubview(phoneButton)
        
        
            let githubImage: UIImage? = UIImage(named: "github")?.imageWithRenderingMode(.AlwaysTemplate)
            let githubButton: IconButton = IconButton()
            githubButton.pulseColor = MaterialColor.blueGrey.darken4
            githubButton.tintColor = MaterialColor.blueGrey.darken4
            githubButton.backgroundColor = MaterialColor.grey.lighten3
            githubButton.setImage(githubImage, forState: .Normal)
            githubButton.setImage(githubImage, forState: .Highlighted)
            contentView.addSubview(githubButton)
        
        
            let linkedinImage: UIImage? = UIImage(named: "linkedin")?.imageWithRenderingMode(.AlwaysTemplate)
            let linkedinButton: IconButton = IconButton()
            linkedinButton.pulseColor = MaterialColor.blueGrey.darken4
            linkedinButton.tintColor = MaterialColor.blueGrey.darken4
            linkedinButton.backgroundColor = MaterialColor.grey.lighten3
            linkedinButton.setImage(linkedinImage, forState: .Normal)
            linkedinButton.setImage(linkedinImage, forState: .Highlighted)
            contentView.addSubview(linkedinButton)
        
            topImageView.grid.rows = 4
            topImageView.grid.columns = 12
            topImageView.backgroundColor = MaterialColor.clear
    
            contentView.grid.rows = 7
            contentView.grid.offset.rows = 4
        
            cardView.grid.axis.direction = .None
            cardView.grid.spacing = 4
            cardView.grid.views = [
                topImageView,
                contentView
            ]

            profileView.grid.rows = 4
            profileView.grid.columns = 6
            profileView.grid.offset.columns = 3
            profileView.grid.offset.rows = 3

            nameLabel.grid.rows = 3
            nameLabel.grid.columns = 12

            titleLabel.grid.rows = 3
            titleLabel.grid.columns = 12
            titleLabel.grid.offset.rows = 2

            companyLabel.grid.rows = 3
            companyLabel.grid.columns = 12
            companyLabel.grid.offset.rows = 4
        

            mailButton.grid.rows = 2
            mailButton.grid.columns = 2
            mailButton.grid.offset.rows = 8
            mailButton.grid.offset.columns = 2
        
            messageButton.grid.rows = 2
            messageButton.grid.columns = 2
            messageButton.grid.offset.rows = 8
            messageButton.grid.offset.columns = 5

            phoneButton.grid.rows = 2
            phoneButton.grid.columns = 2
            phoneButton.grid.offset.rows = 8
            phoneButton.grid.offset.columns = 8

            githubButton.grid.rows = 2
            githubButton.grid.columns = 2
            githubButton.grid.offset.rows = 10
            githubButton.grid.offset.columns = 2

            linkedinButton.grid.rows = 2
            linkedinButton.grid.columns = 2
            linkedinButton.grid.offset.rows = 10
            linkedinButton.grid.offset.columns = 5

            contentView.grid.spacing = 8
            contentView.grid.axis.direction = .None
            contentView.grid.contentInsetPreset = .Square3
            contentView.grid.views = [
                nameLabel,
                titleLabel,
                companyLabel,
                mailButton,
                messageButton,
                phoneButton,
                githubButton,
                linkedinButton
            ]
        topImageView.grid.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        topImageView.grid.views = [
            profileView        ]
        }
}

//        //        _: UIImage? = UIImage(named: "CosmicMindInverted")
//        
//        let cardView: ImageCardView = ImageCardView()
//        Layout.horizontally(view, child:cardView)
//        Layout.vertically(view, child: cardView)
//        cardView.backgroundColor = MaterialColor.pink.lighten1
//        cardView.pulseColor = MaterialColor.white
//        view.addSubview(cardView)
//        
//        let btn1: FlatButton = FlatButton()
//        btn1.pulseColor = MaterialColor.cyan.lighten1
//        btn1.setTitle("YES", forState: .Normal)
//        btn1.setTitleColor(MaterialColor.cyan.darken1, forState: .Normal)
//    
//        let profileView: MaterialView = MaterialView()
//        profileView.image = UIImage(named: "VivianeChan")
//        profileView.shape = .Circle
//        view.addSubview(profileView)
//        
//        let nameLabel: UILabel = UILabel()
//        nameLabel.text = "VIVIANE CHAN"
//        nameLabel.font = UIFont(name: "Avenir", size: 15)
//        nameLabel.textColor = MaterialColor.black
//        view.addSubview(nameLabel)
//
//        let titleLabel: UILabel = UILabel()
//        titleLabel.text = "iOS Developer"
//        titleLabel.font = UIFont(name: "Avenir", size: 15)
//        titleLabel.textColor = MaterialColor.black
//        view.addSubview(titleLabel)
//        
//        let companyLabel: UILabel = UILabel()
//        companyLabel.text = "Lighthouse Labs"
//        companyLabel.font = UIFont(name: "Avenir", size: 15)
//        nameLabel.textColor = MaterialColor.black
//        view.addSubview(companyLabel)
//
//        profileView.grid.rows = 4
//        profileView.grid.columns = 8
//        profileView.grid.offset.rows = 2
//        profileView.grid.offset.columns = 2
//        
//        nameLabel.grid.rows = 1
//        nameLabel.grid.columns = 12
//        nameLabel.grid.offset.rows = 5
//        nameLabel.grid.offset.columns = 1
//        
//        titleLabel.grid.rows = 1
//        titleLabel.grid.columns = 12
//        titleLabel.grid.offset.rows = 6
//        titleLabel.grid.offset.columns = 1
//        
//        companyLabel.grid.rows = 1
//        companyLabel.grid.columns = 12
//        companyLabel.grid.offset.rows = 7
//        companyLabel.grid.offset.columns = 1
//        
//        cardView.leftButtons = [btn1]
//
//        cardView.grid.spacing = 2
//        cardView.grid.axis.direction = .None
//        cardView.grid.contentInsetPreset = .Square3
//        cardView.grid.views = [
////            profileView,
//            nameLabel,
//            titleLabel,
//            companyLabel
//        ]
//        
//        view.layout(cardView).top(100).left(20).right(20)
//
//
//    }
//    
//    func handleMenuButton(){
//        
//    }
//}

            
    
        
    

    

    

