
import UIKit
import Material
import MessageUI


extension ContactsViewController: UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    // required didSelectRowAtIndexPath

    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        prepareLargeCardViewExample()
        
        
//        var cell = tableView.cellForRowAtIndexPath(indexPath) as! ContactsTableViewCell
        switch selectedIndexPath {
        case nil:
            selectedIndexPath = indexPath
        default:
            if selectedIndexPath! == indexPath {
                selectedIndexPath = nil
            } else {
                selectedIndexPath = indexPath
            }
        }
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }

    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let smallHeight: CGFloat = 70.0
        let expandedHeight: CGFloat = 450.0
        let ip = indexPath
        if selectedIndexPath != nil {
            if ip == selectedIndexPath! {
                return expandedHeight
            } else {
                return smallHeight
            }
        } else {
            return smallHeight
        }
    }

    
    
    private func prepareLargeCardViewExample() {
        
            // set container views

            let cardView: MaterialPulseView = MaterialPulseView(frame: CGRectMake(0, 100, view.bounds.width, 450.0))
            cardView.pulseColor = MaterialColor.blueGrey.base
            cardView.depth = .Depth1
        
            view.addSubview(cardView)

            let topImageView: MaterialView = MaterialView()
            cardView.addSubview(topImageView)
        
            let contentView: MaterialView = MaterialView()
            cardView.addSubview(contentView)
        
            let profileView: UIImageView = UIImageView()
            profileView.image = UIImage(named: "VivianeChan") //#PASSDATA image from participant
//            profileView.contentsGravityPreset = .ResizeAspectFill
//            profileView.shape = .Circle
            profileView.contentMode = .ScaleAspectFill
            topImageView.addSubview(profileView)
        
            let closeImage: UIImage? = MaterialIcon.cm.close
            let closeButton: UIButton = UIButton()
            closeButton.tintColor = MaterialColor.blueGrey.darken4
            closeButton.setImage(closeImage, forState: .Normal)
            closeButton.setImage(closeImage, forState: .Highlighted)
            topImageView.addSubview(closeButton)
            closeButton.addTarget(self, action: #selector(handleCloseButton), forControlEvents: .TouchUpInside)
        

            // set labels
            
            let nameLabel: UILabel = UILabel()
            nameLabel.text = "VIVIANE CHAN" //#PASSDATA name from participant
            nameLabel.textAlignment = .Center
            nameLabel.font = UIFont(name: "Avenir-Heavy", size: 15)
            nameLabel.textColor = MaterialColor.black
            contentView.addSubview(nameLabel)
        
            let titleLabel: UILabel = UILabel()
            titleLabel.text = "iOSDeveloper" //#PASSDATA title from participant
            titleLabel.textAlignment = .Center
            titleLabel.font = UIFont(name: "Avenir", size: 15)
            titleLabel.textColor = MaterialColor.grey.darken2
            contentView.addSubview(titleLabel)
        
            let companyLabel: UILabel = UILabel()
            companyLabel.font = UIFont(name: "Avenir", size: 15)
            companyLabel.text = "Lighthouse Labs" //#PASSDATA company from participant
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
            phoneButton.addTarget(self, action: #selector(handlePhoneButton), forControlEvents: .TouchUpInside)

        
            let githubImage: UIImage? = UIImage(named: "github")
            let githubButton: UIButton = UIButton()
            githubButton.tintColor = MaterialColor.blueGrey.darken4
            githubButton.backgroundColor = MaterialColor.grey.lighten3
            githubButton.setImage(githubImage, forState: .Normal)
            githubButton.setImage(githubImage, forState: .Highlighted)
            contentView.addSubview(githubButton)
            githubButton.addTarget(self, action: #selector(handleGithubButton), forControlEvents: .TouchUpInside)

        
            let linkedinImage: UIImage? = UIImage(named: "linkedin")
            let linkedinButton: UIButton = UIButton()
            linkedinButton.tintColor = MaterialColor.blueGrey.darken4
            linkedinButton.backgroundColor = MaterialColor.grey.lighten3
            linkedinButton.setImage(linkedinImage, forState: .Normal)
            linkedinButton.setImage(linkedinImage, forState: .Highlighted)
            contentView.addSubview(linkedinButton)
            linkedinButton.addTarget(self, action: #selector(handleLinkedinButton), forControlEvents: .TouchUpInside)

            // layout containers
        
            topImageView.grid.rows = 4
            topImageView.grid.columns = 12
    
            contentView.grid.rows = 7
            contentView.grid.columns = 12
            contentView.grid.offset.rows = 4
        
            cardView.grid.axis.direction = .None
            cardView.grid.spacing = 4
            cardView.grid.contentInsetPreset = .Square3

            cardView.grid.views = [
                topImageView,
                contentView
            ]

        
            // layout labels topimageView
        
            profileView.grid.rows = 6
            profileView.grid.columns = 6
            profileView.grid.offset.rows = 2
            profileView.grid.offset.columns = 3
        
            closeButton.grid.rows = 3
            closeButton.grid.columns = 2
            closeButton.grid.offset.rows = 0
            closeButton.grid.offset.columns = 11


            topImageView.grid.spacing = 8
            topImageView.grid.axis.direction = .None
            topImageView.grid.contentInsetPreset = .Square3
        
            topImageView.grid.views = [
            profileView, 
            closeButton
            ]
        
        
        // layout labels bottomimageView

            nameLabel.grid.rows = 3
            nameLabel.grid.columns = 12

            titleLabel.grid.rows = 3
            titleLabel.grid.columns = 12
            titleLabel.grid.offset.rows = 2

            companyLabel.grid.rows = 3
            companyLabel.grid.columns = 12
            companyLabel.grid.offset.rows = 4

            mailButton.grid.rows = 3
            mailButton.grid.columns = 3
            mailButton.grid.offset.rows = 7
            mailButton.grid.offset.columns = 2
        
            messageButton.grid.rows = 3
            messageButton.grid.columns = 3
            messageButton.grid.offset.rows = 7
            messageButton.grid.offset.columns = 5

            phoneButton.grid.rows = 3
            phoneButton.grid.columns = 3
            phoneButton.grid.offset.rows = 7
            phoneButton.grid.offset.columns = 8

            githubButton.grid.rows = 3
            githubButton.grid.columns = 3
            githubButton.grid.offset.rows = 10
            githubButton.grid.offset.columns = 2

            linkedinButton.grid.rows = 3
            linkedinButton.grid.columns = 3
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
        
        
        self.view.addSubview(cardView)
        
        }
    
    
    // handle email button
    
    func handleMailButton() {
        let email = MFMailComposeViewController()
        email.mailComposeDelegate = self
        email.setSubject("Hello")
//        email.setMessageBody("Some example text", isHTML: false)
        email.setToRecipients(["vivianechan@hotmail.com"]) // VIV #PASSDATA email from participant
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
    messageVC.recipients = []  // VIV #PASSDATA phone from participant
    messageVC.messageComposeDelegate = self
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

    
    // handle phone button
    
    func handlePhoneButton() {
        let phone = "tel://6474477768"; //#PASSDATA phone from participant
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
    }
    


// handle github button

    func handleGithubButton() {
    UIApplication.sharedApplication().openURL(NSURL(string:"https://github.com/sleepyUdon/")!) //#PASSDATA github from participant
}


// handle linkedin button

    func handleLinkedinButton() {
    UIApplication.sharedApplication().openURL(NSURL(string:"https://www.linkedin.com/in/vivianechan")!) //#PASSDATA linkedin from participant
}


    
    // handle close button
    
    func handleCloseButton() {
        self.view.removeFromSuperview()  //REMOVECONTACT
    }

}





