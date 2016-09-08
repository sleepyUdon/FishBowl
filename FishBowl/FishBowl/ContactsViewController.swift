
import UIKit
import Material
import OAuthSwift
import MessageUI
import CoreData


public class ContactsViewController: UIViewController,UISearchBarDelegate {
    
    let cardView: ImageCardView = ImageCardView()
    public lazy var tableView: UITableView = UITableView()
    private var containerView: UIView!
    var noteField: UITextView?
    private var contactsScrollView: UIScrollView = UIScrollView()
    
    var currentData:NSArray = []
    var filteredContacts:NSArray = []
    var contactsArray:[User] = []
    
    // Reference for SearchBar.
    private var searchBar: UISearchBar!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
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
    
    
    func didUpdateContacs() {
        self.contactsSearchActive = false
        self.tableView.reloadData()
    }
    
    //  viewDidLayoutSubviews
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardOnScreen), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardOffScreen), name: UIKeyboardWillHideNotification, object: nil)
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

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    
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
        cell.contact = currentData[indexPath.row] as! User
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
        
        // set cardview
        let cardView: ImageCardView = ImageCardView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        contactsScrollView = UIScrollView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height-20))
        contactsScrollView.bounces = false
        contactsScrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        contactsScrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        contactsScrollView.contentSize = cardView.bounds.size
        contactsScrollView.addSubview(cardView)
        view.addSubview(contactsScrollView)
        
        
        let profileView: MaterialView = MaterialView(frame: CGRect(x: view.bounds.width/2 - 50, y: 20, width: 100, height: 100))
        profileView.image = UIImage(data: contact.picture!)
        profileView.cornerRadius = 50
        profileView.contentMode = .ScaleAspectFit
        cardView.addSubview(profileView)
        
        let closeImage: UIImage? = MaterialIcon.cm.close
        let closeButton: UIButton = UIButton(frame: CGRect(x: view.bounds.width - 50, y: 20, width: 25, height: 25))
        closeButton.tintColor = Color.accentColor1
        closeButton.setImage(closeImage, forState: .Normal)
        closeButton.setImage(closeImage, forState: .Highlighted)
        cardView.addSubview(closeButton)
        closeButton.tag = indexPath.row
        closeButton.addTarget(self, action: #selector(handleCloseButton), forControlEvents: .TouchUpInside)
        
        
        // set labels
        let nameLabel: UILabel = UILabel(frame: CGRect(x: view.bounds.width/2 - 100, y: 130, width: 200, height: 30))
        nameLabel.text = contact.name
        nameLabel.textAlignment = .Center
        nameLabel.font = Fonts.title
        nameLabel.textColor = Color.greyDark
        cardView.addSubview(nameLabel)
        
        
        let titleLabel: UILabel = UILabel(frame: CGRect(x: view.bounds.width/2 - 100, y: 160, width: 200, height: 30))
        titleLabel.text = contact.title
        titleLabel.textAlignment = .Center
        titleLabel.font = Fonts.bodyGrey
        titleLabel.textColor = Color.greyMedium
        cardView.addSubview(titleLabel)
        
        let companyLabel: UILabel = UILabel(frame: CGRect(x: view.bounds.width/2 - 100, y: 190, width: 200, height: 30))
        companyLabel.font = Fonts.title
        companyLabel.text = contact.valueForKey("company") as? String
        companyLabel.textAlignment = .Center
        companyLabel.textColor = Color.greyMedium
        cardView.addSubview(companyLabel)
        
        let mailImage: UIImage? = UIImage(named: "mail")
        let mailButton: UIButton = UIButton(frame: CGRect(x: 40, y: 200, width: 50, height: 50))
        mailButton.tintColor = Color.baseColor1
        mailButton.setImage(mailImage, forState: .Normal)
        mailButton.setImage(mailImage, forState: .Highlighted)
        mailButton.layer.setValue(contact.email, forKey: "email")
        cardView.addSubview(mailButton)
        mailButton.addTarget(self, action: #selector(handleMailButton), forControlEvents: .TouchUpInside)
        
        
        let messageImage: UIImage? = UIImage(named: "message")
        let messageButton: UIButton = UIButton(frame: CGRect(x: view.bounds.width/2 - 25, y: 200, width: 50, height: 50))
        messageButton.tintColor = Color.baseColor1
        messageButton.setImage(messageImage, forState: .Normal)
        messageButton.setImage(messageImage, forState: .Highlighted)
        messageButton.layer.setValue(contact.phone, forKey: "phone")
        cardView.addSubview(messageButton)
        messageButton.addTarget(self, action: #selector(handleMessageButton), forControlEvents: .TouchUpInside)
        
        
        let phoneImage: UIImage? = UIImage(named:"phone.png")
        let phoneButton: UIButton = UIButton(frame: CGRect(x: view.bounds.width - 90, y: 200, width: 50, height: 50))
        phoneButton.tintColor = Color.baseColor1
        phoneButton.setImage(phoneImage, forState: .Normal)
        phoneButton.setImage(phoneImage, forState: .Highlighted)
        phoneButton.layer.setValue(contact.phone, forKey: "phone")
        cardView.addSubview(phoneButton)
        phoneButton.addTarget(self, action: #selector(handlePhoneButton), forControlEvents: .TouchUpInside)
        
        
        let githubImage: UIImage? = UIImage(named: "github")
        let githubButton: UIButton = UIButton(frame: CGRect(x: 40, y: 250, width: 50, height: 50))
        githubButton.tintColor = Color.baseColor1
        githubButton.setImage(githubImage, forState: .Normal)
        githubButton.setImage(githubImage, forState: .Highlighted)
        githubButton.layer.setValue(contact.github, forKey: "github")
        cardView.addSubview(githubButton)
        githubButton.addTarget(self, action: #selector(handleGithubButton), forControlEvents: .TouchUpInside)
        
        
        let linkedinImage: UIImage? = UIImage(named: "linkedin")
        let linkedinButton: UIButton = UIButton(frame: CGRect(x: view.bounds.width/2 - 25, y: 250, width: 50, height: 50))
        linkedinButton.tintColor = Color.baseColor1
        linkedinButton.setImage(linkedinImage, forState: .Normal)
        linkedinButton.setImage(linkedinImage, forState: .Highlighted)
        linkedinButton.layer.setValue(contact.linkedin, forKey: "linkedin")
        cardView.addSubview(linkedinButton)
        linkedinButton.addTarget(self, action: #selector(handleLinkedinButton), forControlEvents: .TouchUpInside)
        
        let addContactImage: UIImage? = UIImage(named: "addContact")
        let phoneContactButton: UIButton = UIButton(frame: CGRect(x: view.bounds.width - 80, y: 260, width: 30, height: 30))
        phoneContactButton.setImage(addContactImage, forState: .Normal)
        phoneContactButton.setImage(addContactImage, forState: .Highlighted)
        cardView.addSubview(phoneContactButton)
        phoneContactButton.tag = indexPath.row
        phoneContactButton.addTarget(self, action: #selector(handlerSaveToAddressBook), forControlEvents: .TouchUpInside)
        
        
        let noteText = UILabel(frame: CGRect(x: 40, y: 320, width: view.bounds.width - 100.0, height: 30))
        noteText.text = "Notes"
        noteText.font = Fonts.title
        cardView.addSubview(noteText)
        
        let noteField = UITextView(frame: CGRect(x: 40, y: 350, width: view.bounds.width - 80.0, height: view.bounds.height - 400))
        noteField.backgroundColor = MaterialColor.grey.lighten2
        noteField.font = Fonts.bodyGrey
        noteField.text = contact.note
        noteField.textColor = Color.greyDark
        noteField.delegate = self
        self.noteField = noteField
        cardView.addSubview(noteField)

    }
    
    private func updateContactInfo(contactDict:User, id: String) {
        fetchUserInfo(id)
        if let user: User = fetchUserInfo(id) {
            user.setValue(id, forKey: "userID")
            user.setValue(contactDict.name, forKey: "name")
            user.setValue(contactDict.email, forKey: "email")
            user.setValue(contactDict.company, forKey: "company")
            user.setValue(contactDict.phone, forKey: "phone")
            user.setValue(contactDict.picture, forKey: "picture")
            user.setValue(contactDict.github, forKey: "github")
            user.setValue(contactDict.linkedin, forKey: "linkedin")
            user.setValue(contactDict.note, forKey: "note")
            user.setValue(contactDict.title, forKey: "title")
            do {
                try user.managedObjectContext?.save()
            }
            catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
            }
        }
    }
    
    private func fetchUserInfo(contactId: String)->User? {
        let moc = appDelegate.managedObjectContext
        
        //create fetch request
        let fetchRequest = NSFetchRequest()
        
        //create entuity description
        let entityDescription = NSEntityDescription.entityForName("User", inManagedObjectContext: moc)
        let predicate = NSPredicate(format: "userID == %@", contactId)
        
        //add sort descriptor
        let sortDescriptor = NSSortDescriptor(key:"userID", ascending: true)

        //assign fetch request properties
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 1
        fetchRequest.fetchLimit = 1
        fetchRequest.returnsObjectsAsFaults = false
        
        //Execute Fetch Request
        do {
            let result = try moc.executeFetchRequest(fetchRequest).first as? User
            return result
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return nil
    }
    
    // textView Delegate 
    public func textViewShouldEndEditing(textView: UITextView) -> Bool {
        noteField?.resignFirstResponder()
        return true
    }
    
    public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    func keyboardOnScreen(notification: NSNotification){
        let info: NSDictionary  = notification.userInfo!
        let kbSize = info.valueForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue().size
        let contentInsets:UIEdgeInsets  = UIEdgeInsetsMake(0.0, 0.0, kbSize!.height, 0.0)
        contactsScrollView.contentInset = contentInsets
        contactsScrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize!.height
        //you may not need to scroll, see if the active field is already visible
        if (!CGRectContainsPoint(aRect, self.noteField!.frame.origin) ) {
            let scrollPoint:CGPoint = CGPointMake(0.0, self.noteField!.frame.origin.y - kbSize!.height)
            contactsScrollView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    func keyboardOffScreen(notification: NSNotification){
        let contentInsets:UIEdgeInsets = UIEdgeInsetsZero
        contactsScrollView.contentInset = contentInsets
        contactsScrollView.scrollIndicatorInsets = contentInsets
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
        
        let saveToAddressBook = AddressBook()
        if contact.phone != nil || contact.email != nil {
            saveToAddressBook.saveToAddressBook(contact.picture,
                                                name: contact.name!,
                                                email: contact.email,
                                                phone: contact.phone!)
            
            let contactAddedAlert = UIAlertController(title:"\(contact.name!) was successfully added",
                                                      message: nil,
                                                      preferredStyle: .Alert)
            
            contactAddedAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            presentViewController(contactAddedAlert, animated: true, completion: nil)
        }
        let contactAddedAlert = UIAlertController(title:"\(contact.name!) could not be added to AddressBook. Only members with email address and phone number can be added to AddressBook",
                                                  message: nil,
                                                  preferredStyle: .Alert)
        
        contactAddedAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(contactAddedAlert, animated: true, completion: nil)
    }
    
    // handle close button
    func handleCloseButton(button:UIButton) {
        let buttonTag = button.tag
        let contact = self.currentData[buttonTag] as! User
        contact.setValue(noteField?.text, forKey: "note")
        updateContactInfo(contact, id: contact.userID)
        
        UIView.animateWithDuration(0.3) {
            self.contactsScrollView.alpha = 0
            self.cardView.alpha = 0
            UIView.animateWithDuration(0.3, animations: {
                self.tableView.alpha = 1
                }, completion: { (completed) in
                    self.contactsScrollView.removeFromSuperview()
                    for view in self.contactsScrollView.subviews {
                        view.removeFromSuperview()
                    }
                    for view in self.cardView.subviews {
                        view.removeFromSuperview()
                    }
            })
        }
    }
    
    //fetch contacts
    func getAllContacts() {
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
                self.currentData = contactsArray
            }
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
}
