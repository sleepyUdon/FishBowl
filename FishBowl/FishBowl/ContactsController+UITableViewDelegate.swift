//
//  MenuViewController+UITableViewDelegate.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-11-02.
//  Copyright © 2015 Adam Dahan. All rights reserved.
//

import UIKit
import Material
import MessageUI


extension ContactsViewController: UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    /*
    @name   required didSelectRowAtIndexPath
    */
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        prepareLargeCardViewExample()

    }

    private func prepareLargeCardViewExample() {

        
            let cardView: MaterialPulseView = MaterialPulseView(frame: CGRectMake(16, 100, view.bounds.width - 32, 400))
            cardView.pulseColor = MaterialColor.blueGrey.base
            cardView.depth = .Depth1
            view.addSubview(cardView)
            

            let topImageView: MaterialView = MaterialView()
            topImageView.contentsGravityPreset = .ResizeAspectFill
            cardView.addSubview(topImageView)
        
            let profileView: MaterialView = MaterialView()
            profileView.image = UIImage(named: "VivianeChan")
            profileView.contentsGravityPreset = .ResizeAspectFill
            profileView.shape = .Circle
            topImageView.addSubview(profileView)
        
            let contentView: MaterialView = MaterialView()
            contentView.backgroundColor = MaterialColor.clear
            cardView.addSubview(contentView)
            
            let nameLabel: UILabel = UILabel()
            nameLabel.text = "VIVIANE CHAN"
            nameLabel.textAlignment = .Center
            nameLabel.font = UIFont(name: "Avenir-Heavy", size: 15)
            nameLabel.textColor = MaterialColor.black
            contentView.addSubview(nameLabel)
        
            let titleLabel: UILabel = UILabel()
            titleLabel.text = "iOSDeveloper"
            titleLabel.textAlignment = .Center
            titleLabel.font = UIFont(name: "Avenir", size: 15)
            titleLabel.textColor = MaterialColor.grey.darken2
            contentView.addSubview(titleLabel)
        
            let companyLabel: UILabel = UILabel()
            companyLabel.font = UIFont(name: "Avenir", size: 15)
            companyLabel.text = "Lighthouse Labs"
            companyLabel.textAlignment = .Center
            companyLabel.textColor = MaterialColor.grey.darken4
            contentView.addSubview(companyLabel)
        
            let mailImage: UIImage? = UIImage(named: "mail")
            let mailButton: UIButton = UIButton()
            mailButton.tintColor = MaterialColor.blueGrey.darken4
            mailButton.backgroundColor = MaterialColor.grey.lighten3
            mailButton.setImage(mailImage, forState: .Normal)
            mailButton.setImage(mailImage, forState: .Highlighted)
            contentView.addSubview(mailButton)
            mailButton.addTarget(self, action: #selector(handleMailButton), forControlEvents: .TouchUpInside)
        

            let messageImage: UIImage? = UIImage(named: "message")
            let messageButton: UIButton = UIButton()
            messageButton.tintColor = MaterialColor.blueGrey.darken4
//            messageButton.backgroundColor = MaterialColor.grey.lighten3
            messageButton.setImage(messageImage, forState: .Normal)
            messageButton.setImage(messageImage, forState: .Highlighted)
            contentView.addSubview(messageButton)
            messageButton.addTarget(self, action: #selector(handleMessageButton), forControlEvents: .TouchUpInside)


            let phoneImage: UIImage? = UIImage(named:"phone.png")
            let phoneButton: UIButton = UIButton()
            phoneButton.tintColor = MaterialColor.blueGrey.darken4
            phoneButton.backgroundColor = MaterialColor.grey.lighten3
            phoneButton.setImage(phoneImage, forState: .Normal)
            phoneButton.setImage(phoneImage, forState: .Highlighted)
            contentView.addSubview(phoneButton)
        
        
            let githubImage: UIImage? = UIImage(named: "github")
            let githubButton: UIButton = UIButton()
            githubButton.tintColor = MaterialColor.blueGrey.darken4
            githubButton.backgroundColor = MaterialColor.grey.lighten3
            githubButton.setImage(githubImage, forState: .Normal)
            githubButton.setImage(githubImage, forState: .Highlighted)
            contentView.addSubview(githubButton)
        
        
            let linkedinImage: UIImage? = UIImage(named: "linkedin")
            let linkedinButton: UIButton = UIButton()
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
    
    
    // handle email button
    
    func handleMailButton() {
        let email = MFMailComposeViewController()
        email.mailComposeDelegate = self
        email.setSubject("Hello")
//        email.setMessageBody("Some example text", isHTML: false)
        email.setToRecipients(["vivianechan@hotmail.com"]) // the recipient email address
        if MFMailComposeViewController.canSendMail() {
            presentViewController(email, animated: true, completion: nil)
        }
    }
    
    
    public func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    // handle message button
    
    func handleMessageButton(){
    let messageVC = MFMessageComposeViewController()
    messageVC.body = "Message string"
    messageVC.recipients = [] // Optionally add some tel numbers
    messageVC.messageComposeDelegate = self
    // Open the SMS View controller
    presentViewController(messageVC, animated: true, completion: nil)
    }
    
    
    public func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResultCancelled.rawValue :
            print("message canceled")
            
        case MessageComposeResultFailed.rawValue :
            print("message failed")
            
        case MessageComposeResultSent.rawValue :
            print("message sent")
            
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}




