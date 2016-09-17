
import UIKit
import Material
import OAuthSwift
import MessageUI
import CoreData


open class ContactsViewController: UIViewController,UISearchBarDelegate {
    
    let cardView: ImageCardView = ImageCardView()
    open lazy var tableView: UITableView = UITableView()
    fileprivate var containerView: UIView!
    var noteField: UITextView?
    fileprivate var contactsScrollView: UIScrollView = UIScrollView()
    
    var currentData:NSArray = []
    var filteredContacts:NSArray = []
    var contactsArray:[User] = []
    
    // Reference for SearchBar.
    fileprivate var searchBar: UISearchBar!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var contactsSearchActive:Bool! {
        didSet {
            updateModel()
        }
    }
    
    fileprivate func updateModel() {
        if contactsSearchActive == true && filteredContacts.count > 0 {
            currentData = filteredContacts
        }
        else {
            currentData = contactsArray as NSArray
        }
        self.tableView.reloadData()
    }
    
    
    open override func viewDidLoad() {
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
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOnScreen), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOffScreen), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Prepares the closeButton
    fileprivate func prepareCloseButton() {
        let closeImage: UIImage? = MaterialIcon.cm.close
        let closeButton = UIButton(frame: CGRect(x: searchBar.frame.width, y: 20, width: 40, height: 44))
        closeButton.tintColor = Color.accentColor1
        closeButton.backgroundColor = UIColor.white
        closeButton.setImage(closeImage, for: UIControlState())
        closeButton.setImage(closeImage, for: .highlighted)
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(handleCloseViewButton), for: .touchDown)
    }
    
    
    func handleCloseViewButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Prepares the searchBar
    fileprivate func prepareSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 20, width: view.frame.width - 40, height: 44))
        searchBar.barTintColor =  UIColor.white
        searchBar.backgroundColor = UIColor.white
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    open func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        contactsSearchActive = true;
    }
    
    open func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        contactsSearchActive = false;
    }
    
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        contactsSearchActive = false;
        tableView.reloadData()
    }
    
    open func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        contactsSearchActive = false;
    }
    
    open func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let contacts = contactsArray
        
        let results = contacts.filter {
            let contact = $0
            return contact.name!.range(of: searchText, options: .caseInsensitive) != nil
        }
        
        filteredContacts = results as NSArray
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
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "Cell")
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
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     @name   numberOfRowsInSection
     */
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    
    /*
     @name   cellForRowAtIndexPath
     */
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactsTableViewCell
        cell.contact = currentData[(indexPath as NSIndexPath).row] as! User
        return cell
    }
    
    
    // required didSelectRowAtIndexPath
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        prepareLargeCardViewExample(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    fileprivate func prepareLargeCardViewExample(_ indexPath:IndexPath) {
        
        //let contacts = contactsModel.contacts
        let contact = currentData[(indexPath as NSIndexPath).row] as! User
        
        // set cardview
        let cardView: ImageCardView = ImageCardView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        cardView.pulseAnimation = .none
        contactsScrollView = UIScrollView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height))
        contactsScrollView.bounces = false
        contactsScrollView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        contactsScrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        contactsScrollView.contentSize = cardView.bounds.size
        contactsScrollView.addSubview(cardView)
        view.addSubview(contactsScrollView)
        
        let profileView: UIImageView = UIImageView(frame: CGRect(x: 20.0, y: 20.0, width: 70, height: 70))
        profileView.image = UIImage(data: contact.picture! as Data)
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 35
        profileView.contentMode = .scaleAspectFill
        cardView.addSubview(profileView)
        
        let closeImage: UIImage? = MaterialIcon.cm.close
        let closeButton: UIButton = UIButton(frame: CGRect(x: view.bounds.width - 50, y: 20, width: 25, height: 25))
        closeButton.tintColor = Color.accentColor1
        closeButton.setImage(closeImage, for: UIControlState())
        closeButton.setImage(closeImage, for: .highlighted)
        cardView.addSubview(closeButton)
        closeButton.tag = (indexPath as NSIndexPath).row
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchDown)
        
        
        // set labels
        let nameLabel: UILabel = UILabel(frame: CGRect(x: 100.0, y: 20.0, width: view.frame.width-200.0, height: 25))
        nameLabel.text = contact.name
        nameLabel.numberOfLines = 0
        nameLabel.font = Fonts.title
        nameLabel.textColor = Color.greyDark
        cardView.addSubview(nameLabel)
        
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 100.0, y: 45, width: view.frame.width-200.0, height: 25))
        titleLabel.text = contact.title
        titleLabel.numberOfLines = 0
        titleLabel.font = Fonts.bodyGrey
        titleLabel.textColor = Color.greyMedium
        cardView.addSubview(titleLabel)
        
        let companyLabel: UILabel = UILabel(frame: CGRect(x: 100.0, y: 70, width: view.frame.width-200.0, height: 25))
        companyLabel.font = Fonts.bodyGrey
        companyLabel.text = contact.value(forKey: "company") as? String
        companyLabel.textColor = Color.greyMedium
        cardView.addSubview(companyLabel)
        
        let phoneTitle: UILabel = UILabel(frame: CGRect(x: 20.0, y: 100, width: view.frame.width-40.0, height: 30))
        phoneTitle.font = Fonts.pinkTitle
        phoneTitle.text = "Phone"
        phoneTitle.textColor = Color.accentColor1
        cardView.addSubview(phoneTitle)
        
        let phoneNumber: UILabel = UILabel(frame: CGRect(x: 20.0, y: 120.0, width: view.frame.width-40.0, height: 30))
        phoneNumber.font = Fonts.bodyGrey
        phoneNumber.text = "(647)836-5162"
        phoneNumber.textColor = Color.greyDark
        cardView.addSubview(phoneNumber)
        
        let phoneImage: UIImage? = UIImage(named:"phone.png")
        let phoneButton: UIButton = UIButton(frame: CGRect(x:  view.frame.width - 70.0, y: 110.0, width: 50, height: 50))
        phoneButton.tintColor = Color.accentColor1
        phoneButton.setImage(phoneImage, for: UIControlState())
        phoneButton.setImage(phoneImage, for: .highlighted)
        phoneButton.layer.setValue(contact.phone, forKey: "phone")
        cardView.addSubview(phoneButton)
        phoneButton.addTarget(self, action: #selector(handlePhoneButton), for: .touchUpInside)
        
        let messageImage: UIImage? = UIImage(named: "message")
        let messageButton: UIButton = UIButton(frame: CGRect(x: view.frame.width - 110.0, y: 110.0, width: 50, height: 50))
        messageButton.tintColor = Color.accentColor1
        messageButton.setImage(messageImage, for: UIControlState())
        messageButton.setImage(messageImage, for: .highlighted)
        messageButton.layer.setValue(contact.phone, forKey: "phone")
        cardView.addSubview(messageButton)
        messageButton.addTarget(self, action: #selector(handleMessageButton), for: .touchUpInside)
        
        let emailTitle: UILabel = UILabel(frame: CGRect(x: 20.0, y: 160.0, width: view.frame.width-40.0, height: 30))
        emailTitle.font = Fonts.pinkTitle
        emailTitle.text = "Email"
        emailTitle.textColor = Color.accentColor1
        cardView.addSubview(emailTitle)
        
        let emailAddress: UILabel = UILabel(frame: CGRect(x: 20.0, y: 180.0, width: view.frame.width-40.0, height: 30))
        emailAddress.font = Fonts.bodyGrey
        emailAddress.text = "vivianechan@hotmail.com"
        emailAddress.textColor = Color.greyDark
        cardView.addSubview(emailAddress)
        
        let mailImage: UIImage? = UIImage(named: "mail")
        let mailButton: UIButton = UIButton(frame: CGRect(x: view.frame.width - 70.0, y: 170.0, width:50, height: 50))
        mailButton.tintColor = Color.baseColor1
        mailButton.setImage(mailImage, for: UIControlState())
        mailButton.setImage(mailImage, for: .highlighted)
        mailButton.layer.setValue(contact.email, forKey: "email")
        cardView.addSubview(mailButton)
        mailButton.addTarget(self, action: #selector(handleMailButton), for: .touchUpInside)
        
        let githubTitle: UILabel = UILabel(frame: CGRect(x: 20.0, y: 220, width: view.frame.width-40.0, height: 30))
        githubTitle.font = Fonts.pinkTitle
        githubTitle.text = "Github"
        githubTitle.textColor = Color.accentColor1
        cardView.addSubview(githubTitle)
        
        let githubLink: UILabel = UILabel(frame: CGRect(x: 20.0, y: 240.0, width: view.frame.width-40.0, height: 30))
        githubLink.font = Fonts.bodyGrey
        githubLink.text = "github/sleepyudon"
        githubLink.textColor = Color.greyDark
        cardView.addSubview(githubLink)
        
        let githubImage: UIImage? = UIImage(named: "github")
        let githubButton: UIButton = UIButton(frame: CGRect(x: view.frame.width - 75.0, y: 220.0, width:60, height: 60))
        githubButton.tintColor = Color.baseColor1
        githubButton.setImage(githubImage, for: UIControlState())
        githubButton.setImage(githubImage, for: .highlighted)
        githubButton.layer.setValue(contact.github, forKey: "github")
        cardView.addSubview(githubButton)
        githubButton.addTarget(self, action: #selector(handleGithubButton), for: .touchUpInside)
        
        let linkedinTitle: UILabel = UILabel(frame: CGRect(x: 20.0, y: 280.0, width: view.frame.width-40.0, height: 30))
        linkedinTitle.font = Fonts.pinkTitle
        linkedinTitle.text = "LinkedIn"
        linkedinTitle.textColor = Color.accentColor1
        cardView.addSubview(linkedinTitle)
        
        let linkedinLink: UILabel = UILabel(frame: CGRect(x: 20.0, y: 300.0, width: view.frame.width-40.0, height: 30))
        linkedinLink.font = Fonts.bodyGrey
        linkedinLink.text = "linkedin/Viviane"
        linkedinLink.textColor = Color.greyDark
        cardView.addSubview(linkedinLink)
        
        let linkedinImage: UIImage? = UIImage(named: "linkedin")
        let linkedinButton: UIButton = UIButton(frame: CGRect(x: view.frame.width - 75.0, y: 280.0, width:60, height: 60))
        linkedinButton.tintColor = Color.baseColor1
        linkedinButton.setImage(linkedinImage, for: UIControlState())
        linkedinButton.setImage(linkedinImage, for: .highlighted)
        linkedinButton.layer.setValue(contact.linkedin, forKey: "linkedin")
        cardView.addSubview(linkedinButton)
        linkedinButton.addTarget(self, action: #selector(handleLinkedinButton), for: .touchUpInside)
        
        let addContactTitle: UIButton = UIButton(frame: CGRect(x: 20.0, y: 350.0, width: view.frame.width-40.0, height: 30))
        addContactTitle.setTitle("Save Contact to Phone Address Book", for: UIControlState())
        addContactTitle.setTitleColor(Color.accentColor1, for: UIControlState())
        addContactTitle.setTitleColor(Color.greyDark, for: .selected)
        addContactTitle.layer.cornerRadius = 15.0
        addContactTitle.layer.borderWidth = 1.0
        addContactTitle.layer.borderColor = Color.accentColor1.cgColor
        addContactTitle.titleLabel?.textAlignment = .center
        addContactTitle.titleLabel?.font = Fonts.pinkTitle
        addContactTitle.tag = (indexPath as NSIndexPath).row
        addContactTitle.addTarget(self, action: #selector(handlerSaveToAddressBook), for: .touchUpInside)
        cardView.addSubview(addContactTitle)
        
        
        let notesTitle: UILabel = UILabel(frame: CGRect(x: 20.0, y: 400.0, width: view.frame.width-40.0, height: 30))
        notesTitle.font = Fonts.pinkTitle
        notesTitle.text = "Notes"
        notesTitle.textColor = Color.accentColor1
        cardView.addSubview(notesTitle)
        
        let noteField = UITextView(frame: CGRect(x: 20, y: 430.0, width: view.bounds.width - 40.0, height: 30.0))
        noteField.backgroundColor = MaterialColor.grey.lighten2
        noteField.font = Fonts.bodyGrey
        noteField.text = contact.note
        noteField.textColor = Color.greyDark
        noteField.delegate = self
        self.noteField = noteField
        cardView.addSubview(noteField)

    }
    
    fileprivate func updateContactInfo(_ contactDict:User, id: String) {
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
    
    fileprivate func fetchUserInfo(_ contactId: String)->User? {
        let moc = appDelegate.managedObjectContext
        
        //create fetch request
        let fetchRequest = NSFetchRequest()
        
        //create entuity description
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: moc)
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
            let result = try moc.fetch(fetchRequest).first as? User
            return result
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return nil
    }
    
    // textView Delegate 
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        noteField?.resignFirstResponder()
        return true
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    func keyboardOnScreen(_ notification: Notification){
        let info: NSDictionary  = (notification as NSNotification).userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject).cgRectValue.size
        let contentInsets:UIEdgeInsets  = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        contactsScrollView.contentInset = contentInsets
        contactsScrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
        //you may not need to scroll, see if the active field is already visible
        if (!aRect.contains(self.noteField!.frame.origin) ) {
            let scrollPoint:CGPoint = CGPoint(x: 0.0, y: self.noteField!.frame.origin.y - kbSize.height)
            contactsScrollView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    func keyboardOffScreen(_ notification: Notification){
        let contentInsets:UIEdgeInsets = UIEdgeInsets.zero
        contactsScrollView.contentInset = contentInsets
        contactsScrollView.scrollIndicatorInsets = contentInsets
    }
    
    // handle email button
    func handleMailButton(_ button:UIButton) {
        let email = MFMailComposeViewController()
        let emailAddress = button.layer.value(forKey: "email") as! String
        email.mailComposeDelegate = self
        email.setSubject("Hello")
        email.setToRecipients([emailAddress]) // VIV #PASSDATA email from participant
        if MFMailComposeViewController.canSendMail() {
            present(email, animated: true, completion: nil)
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    // handle message button
    func handleMessageButton(_ button:UIButton){
        let messageVC = MFMessageComposeViewController()
        let phoneNumber = button.layer.value(forKey: "phone") as! String
        messageVC.recipients = [phoneNumber]
        messageVC.messageComposeDelegate = self
        present(messageVC, animated: true, completion: nil)
    }
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue :
            print("message canceled")
            
        case MessageComposeResult.failed.rawValue :
            print("message failed")
            
        case MessageComposeResult.sent.rawValue :
            print("message sent")
            
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    // handle phone button
    func handlePhoneButton(_ button:UIButton) {
        
        let phoneNumber = button.layer.value(forKey: "phone") as! String
        let phone = "tel://" + phoneNumber
        let url:URL = URL(string:phone)!;
        UIApplication.shared.openURL(url);
    }
    
    // handle github button
    func handleGithubButton(_ button:UIButton) {
        let github = button.layer.value(forKey: "github") as! String
        UIApplication.shared.openURL(URL(string:github)!)
        
    }
    
    // handle linkedin button
    func handleLinkedinButton(_ button:UIButton) {
        let linkedin = button.layer.value(forKey: "linkedin") as! String
        if linkedin != "" {
            UIApplication.shared.openURL(URL(string:linkedin)!)
            
        }
    }
    
    //handle saving to AddressBook
    func handlerSaveToAddressBook(_ button: UIButton) {
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
                                                      preferredStyle: .alert)
            
            contactAddedAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(contactAddedAlert, animated: true, completion: nil)
        }
        let contactAddedAlert = UIAlertController(title:"\(contact.name!) could not be added to AddressBook. Only members with email address and phone number can be added to AddressBook",
                                                  message: nil,
                                                  preferredStyle: .alert)
        
        contactAddedAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(contactAddedAlert, animated: true, completion: nil)
    }
    
    // handle close button
    func handleCloseButton(_ button:UIButton) {
        let buttonTag = button.tag
        let contact = self.currentData[buttonTag] as! User
        contact.setValue(noteField?.text, forKey: "note")
        updateContactInfo(contact, id: contact.userID)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contactsScrollView.alpha = 0
            self.cardView.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
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
        }) 
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
            let result = try moc.fetch(fetchRequest) as! [User]
            
            if result.count != 0 {
                for user in result {
                    contactsArray.append(user)
                }
                self.currentData = contactsArray as NSArray
            }
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
}
