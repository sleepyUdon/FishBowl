
import UIKit
import Material
import OAuthSwift
import MessageUI
import CoreData

public class ContactsViewController: UIViewController,UISearchBarDelegate {
    
    let cardView: MaterialPulseView = MaterialPulseView(frame: CGRect.zero)
    public lazy var tableView: UITableView = UITableView()
    private var containerView: UIView!

    
    var currentData:NSArray = []
    var filteredContacts:NSArray = []
    var contactsArray:[User] = []
    
    // Reference for SearchBar.
    private var searchBar: UISearchBar!
    
    
    
    var contactsSearchActive:Bool! {
        didSet {
            updateModel()
        }
    }
    
    private func updateModel() {
        if contactsSearchActive == true && filteredContacts.count > 0 {
            currentData = filteredContacts
        }
        else {
            currentData = contactsArray
        }
        self.tableView.reloadData()
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        getAllContacts()
        prepareView()
        prepareTableView()
        didUpdateContacs()
        prepareSearchBar()
        prepareCloseButton()
        cardView.alpha = 0.0
    }
    
//    public override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tableView.reloadData()
//    }
    
  
    func didUpdateContacs() {
        currentData = contactsArray
        self.contactsSearchActive = false
        print(currentData.count)
        print(currentData)
        print(self, "self contacts view controller")
        self.tableView.reloadData()
    }
    
    //  viewDidLayoutSubviews
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
        cardView.frame = CGRectMake(0, 0, view.bounds.width, 450.0)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

    // Prepares the closeButton
    private func prepareCloseButton() {
        let closeImage: UIImage? = MaterialIcon.cm.close
        let closeButton = UIButton(frame: CGRectMake(searchBar.frame.width, 20, 40, 44))
        closeButton.tintColor = Color.accentColor1
        closeButton.backgroundColor = UIColor.whiteColor()
        closeButton.setImage(closeImage, forState: .Normal)
        closeButton.setImage(closeImage, forState: .Highlighted)
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(handleCloseViewButton), forControlEvents: .TouchUpInside)
    }
    
    
    func handleCloseViewButton(){
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // Prepares the searchBar
    private func prepareSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 20, width: view.frame.width - 40, height: 44))
        searchBar.barTintColor =  UIColor.whiteColor()
        searchBar.backgroundColor = UIColor.whiteColor()
        searchBar.searchBarStyle = UISearchBarStyle.Minimal

        
      
        
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        contactsSearchActive = true;
    }
    
    public func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        contactsSearchActive = false;
    }
    
    public func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        contactsSearchActive = false;
        tableView.reloadData()

    }
    
    public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        contactsSearchActive = false;
    }
    
    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let contacts = contactsArray
        
        let results = contacts.filter {
            let contact = $0
            return contact.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        }
        
        filteredContacts = results
        updateModel()
        
    }
}

extension ContactsViewController {
    
    // prepareView
    public func prepareView() {
        view.backgroundColor = MaterialColor.grey.lighten2

    }
    
    // prepareTableView
    public func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(ContactsTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    // layoutTableView
    public func layoutTableView() {
        view.layout(tableView).edges(top: 64, left: 0, right: 0)
    }
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    /*
     @name   numberOfSectionsInTableView
     */
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     @name   numberOfRowsInSection
     */
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentData.count
    }
    
    
    /*
     @name   cellForRowAtIndexPath
     */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ContactsTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ContactsTableViewCell
//         =  tableView.dequeueReusableCellWithIdentifier("Cell") as! ContactsTableViewCell
        cell.contact = currentData[indexPath.row] as! User
        print(currentData.count)
        return cell
    }
    
    
    // required didSelectRowAtIndexPath
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        prepareLargeCardViewExample(indexPath)
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    private func prepareLargeCardViewExample(indexPath:NSIndexPath) {
        
        //let contacts = contactsModel.contacts
        let contact = currentData[indexPath.row] as! User
        
        // set container views
        cardView.pulseColor = Color.baseColor1
        cardView.borderWidth = 0
        
        view.addSubview(cardView)
        
        let topImageView: MaterialView = MaterialView()
        cardView.addSubview(topImageView)
        
        let contentView: MaterialView = MaterialView()
        cardView.addSubview(contentView)
        
        let profileView: MaterialView = MaterialView()

        profileView.image = UIImage(data: contact.picture!)
        profileView.shape = .Circle
        topImageView.addSubview(profileView)
        
        let closeImage: UIImage? = MaterialIcon.cm.close
        let closeButton: UIButton = UIButton()
        closeButton.tintColor = Color.accentColor1
        closeButton.setImage(closeImage, forState: .Normal)
        closeButton.setImage(closeImage, forState: .Highlighted)
        topImageView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(handleCloseButton), forControlEvents: .TouchUpInside)
        
        
        // set labels
        let nameLabel: UILabel = UILabel()
        nameLabel.text = contact.name
        nameLabel.textAlignment = .Center
        nameLabel.font = Fonts.title
        nameLabel.textColor = Color.greyDark
        contentView.addSubview(nameLabel)
        
        
        let titleLabel: UILabel = UILabel()
        titleLabel.text = contact.title
        titleLabel.textAlignment = .Center
        titleLabel.font = Fonts.bodyGrey
        titleLabel.textColor = Color.greyMedium
        contentView.addSubview(titleLabel)
        
        let companyLabel: UILabel = UILabel()
        companyLabel.font = Fonts.title
        companyLabel.text = contact.valueForKey("company") as? String//#PASSDATA company from participant
        companyLabel.textAlignment = .Center
        companyLabel.textColor = Color.greyMedium
        contentView.addSubview(companyLabel)
        
        let mailImage: UIImage? = UIImage(named: "mail")
        let mailButton: UIButton = UIButton()
        mailButton.tintColor = Color.baseColor1
        mailButton.setImage(mailImage, forState: .Normal)
        mailButton.setImage(mailImage, forState: .Highlighted)
        mailButton.layer.setValue(contact.email, forKey: "email")
        contentView.addSubview(mailButton)
        mailButton.addTarget(self, action: #selector(handleMailButton), forControlEvents: .TouchUpInside)
        
        
        let messageImage: UIImage? = UIImage(named: "message")
        let messageButton: UIButton = UIButton()
        messageButton.tintColor = Color.baseColor1
        messageButton.setImage(messageImage, forState: .Normal)
        messageButton.setImage(messageImage, forState: .Highlighted)
        messageButton.layer.setValue(contact.phone, forKey: "phone")
        contentView.addSubview(messageButton)
        messageButton.addTarget(self, action: #selector(handleMessageButton), forControlEvents: .TouchUpInside)
        
        
        let phoneImage: UIImage? = UIImage(named:"phone.png")
        let phoneButton: UIButton = UIButton()
        phoneButton.tintColor = Color.baseColor1
        phoneButton.setImage(phoneImage, forState: .Normal)
        phoneButton.setImage(phoneImage, forState: .Highlighted)
        phoneButton.layer.setValue(contact.phone, forKey: "phone")
        contentView.addSubview(phoneButton)
        phoneButton.addTarget(self, action: #selector(handlePhoneButton), forControlEvents: .TouchUpInside)
        
        
        let githubImage: UIImage? = UIImage(named: "github")
        let githubButton: UIButton = UIButton()
        githubButton.tintColor = Color.baseColor1
        githubButton.setImage(githubImage, forState: .Normal)
        githubButton.setImage(githubImage, forState: .Highlighted)
        githubButton.layer.setValue(contact.github, forKey: "github")
        contentView.addSubview(githubButton)
        githubButton.addTarget(self, action: #selector(handleGithubButton), forControlEvents: .TouchUpInside)
        
        
        let linkedinImage: UIImage? = UIImage(named: "linkedin")
        let linkedinButton: UIButton = UIButton()
        linkedinButton.tintColor = Color.baseColor1
        linkedinButton.setImage(linkedinImage, forState: .Normal)
        linkedinButton.setImage(linkedinImage, forState: .Highlighted)
        linkedinButton.layer.setValue(contact.linkedin, forKey: "linkedin")
        contentView.addSubview(linkedinButton)
        linkedinButton.addTarget(self, action: #selector(handleLinkedinButton), forControlEvents: .TouchUpInside)
        
        let phoneContactButton: MaterialButton = MaterialButton()
        phoneContactButton.pulseColor = MaterialColor.white
        phoneContactButton.depth = .Depth1
        phoneContactButton.titleLabel?.font = Fonts.bodyGrey
        phoneContactButton.cornerRadius = 5.0
        phoneContactButton.setTitleColor(Color.greyDark, forState: .Normal)
        phoneContactButton.setTitle("Save to Contacts", forState: UIControlState.Normal)
        phoneContactButton.backgroundColor = MaterialColor.grey.lighten4
        contentView.addSubview(phoneContactButton)
        ////
        phoneContactButton.tag = indexPath.row
        ////
        phoneContactButton.addTarget(self, action: #selector(handlerSaveToAddressBook), forControlEvents: .TouchUpInside)
        
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
        Layout.centerHorizontally(topImageView, child: profileView)
        profileView.grid.rows = 12
        profileView.grid.columns = 4
        profileView.grid.offset.rows = 2
        profileView.grid.offset.columns = 4
        
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
        titleLabel.grid.offset.rows = 1
        
        companyLabel.grid.rows = 3
        companyLabel.grid.columns = 12
        companyLabel.grid.offset.rows = 3
        
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
        githubButton.grid.offset.rows = 9
        githubButton.grid.offset.columns = 2
        
        linkedinButton.grid.rows = 3
        linkedinButton.grid.columns = 3
        linkedinButton.grid.offset.rows = 9
        linkedinButton.grid.offset.columns = 5
        
        phoneContactButton.grid.rows = 2
        phoneContactButton.grid.columns = 8
        phoneContactButton.grid.offset.rows = 5
        phoneContactButton.grid.offset.columns = 2
        
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
            linkedinButton,
            phoneContactButton
        ]
        
        self.view.addSubview(cardView)
        UIView.animateWithDuration(0.3) {
            self.tableView.alpha = 0
            self.cardView.alpha = 1
        }
    }
    
    // handle email button
    func handleMailButton(button:UIButton) {
        let email = MFMailComposeViewController()
        let emailAddress = button.layer.valueForKey("email") as! String
        email.mailComposeDelegate = self
        email.setSubject("Hello")
        email.setToRecipients([emailAddress]) // VIV #PASSDATA email from participant
        if MFMailComposeViewController.canSendMail() {
            presentViewController(email, animated: true, completion: nil)
        }
    }
    
    public func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // handle message button
    func handleMessageButton(button:UIButton){
        let messageVC = MFMessageComposeViewController()
        let phoneNumber = button.layer.valueForKey("phone") as! String
        messageVC.recipients = [phoneNumber]
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
    func handlePhoneButton(button:UIButton) {
        
        let phoneNumber = button.layer.valueForKey("phone") as! String
        let phone = "tel://" + phoneNumber
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
    }
    
    // handle github button
    func handleGithubButton(button:UIButton) {
        
        let github = button.layer.valueForKey("github") as! String
        
        UIApplication.sharedApplication().openURL(NSURL(string:github)!)
        
    }
    
    // handle linkedin button
    func handleLinkedinButton(button:UIButton) {
        
        let linkedin = button.layer.valueForKey("linkedin") as! String
        if linkedin != "" {
            
            UIApplication.sharedApplication().openURL(NSURL(string:linkedin)!)
            
        }
    }
    
    //handle saving to AddressBook
    func handlerSaveToAddressBook(button: UIButton) {
        let buttonTag = button.tag
        let contact = currentData[buttonTag] as! User
        
        if #available(iOS 9.0, *) {
            let saveToAddressBook = AddressBook()
            if contact.phone != nil {
                saveToAddressBook.saveToAddressBook(contact.picture, name: contact.name!, email: contact.email, phone: contact.phone!)
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    // handle close button
    func handleCloseButton() {
        UIView.animateWithDuration(0.3) {
            self.cardView.alpha = 0
            UIView.animateWithDuration(0.3, animations: {
                self.tableView.alpha = 1
                }, completion: { (completed) in
                    self.cardView.removeFromSuperview()  //REMOVECONTACT
            })
        }
    }

    //fetch contacts
    func getAllContacts() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        contactsArray = []
        //create fetch request
        let fetchRequest = NSFetchRequest(entityName:"User")
        
        //add sort descriptor
        let sortDescriptor = NSSortDescriptor(key:"userID", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.returnsObjectsAsFaults = false
        //Execute Fetch Request
        do {
            let result = try moc.executeFetchRequest(fetchRequest) as! [User]
            
            if result.count != 0 {
                for user in result {
                    contactsArray.append(user)
                }
            }
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
}


