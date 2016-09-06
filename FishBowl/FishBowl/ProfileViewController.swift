//  ProfileViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io. All rights reserved.

import UIKit
import Material
import CoreData
import Firebase

private var saveButton: MaterialButton!
private var cancelButton: MaterialButton!
private var scrollView: UIScrollView = UIScrollView()
private var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()


class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let picker = UIImagePickerController()
    
    var activeField: UITextField?
    var profileView: MaterialView!
    var nameTextField : UITextField!
    var titleTextField : UITextField!
    var companyTextField : UITextField!
    var emailTextField : UITextField!
    var phoneTextField : UITextField!
    var githubTextField : UITextField!
    var linkedinTextField : UITextField!
    
    let ref = FIRDatabase.database().reference()
    
    //    viewDid Load
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareSaveButton()
        prepareCancelButton()
        prepareCardView()
        prepareNavigationItem()
        prepareNavigationBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardOnScreen), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardOffScreen), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //    Setup Keyboard an textfields
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeField = textField
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardOnScreen(notification: NSNotification){
        let info: NSDictionary  = notification.userInfo!
        let kbSize = info.valueForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue().size
        let contentInsets:UIEdgeInsets  = UIEdgeInsetsMake(0.0, 0.0, kbSize!.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize!.height
        //you may not need to scroll, see if the active field is already visible
        if (!CGRectContainsPoint(aRect, activeField!.frame.origin) ) {
            let scrollPoint:CGPoint = CGPointMake(0.0, activeField!.frame.origin.y - kbSize!.height)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
        
    }
    
    func keyboardOffScreen(notification: NSNotification){
        let contentInsets:UIEdgeInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    //    Prepare and Handle Save Button
    private func prepareSaveButton() {
        saveButton = MaterialButton()
        saveButton.setTitle("Save", forState: .Normal)
        saveButton.setTitleColor(Color.accentColor1, forState: .Normal)
        saveButton.pulseColor = Color.accentColor1
        saveButton.titleLabel!.font = Fonts.title
        saveButton.addTarget(self, action: #selector(handleSaveButton), forControlEvents: .TouchUpInside)
    }

    private func prepareCancelButton() {
        cancelButton = MaterialButton()
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.setTitleColor(Color.accentColor1, forState: .Normal)
        cancelButton.pulseColor = Color.accentColor1
        cancelButton.titleLabel!.font = Fonts.title
        cancelButton.addTarget(self, action: #selector(handleCancelButton), forControlEvents: .TouchUpInside)

    }

    //handle save and cancel button
    func handleSaveButton() {
        
        let context = self.appDelegate.managedObjectContext
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as! User
        
        user.name = nameTextField.text
        user.title = titleTextField.text
        user.company = companyTextField.text
        user.email = emailTextField.text
        
        user.phone = removeNonNumericCharsFromString(phoneTextField.text!)
        user.github = githubTextField.text
        user.linkedin = linkedinTextField.text
        user.picture = UIImagePNGRepresentation(self.profileView.image!)
        
        do {
            //save
            try user.managedObjectContext?.save()
            dismissViewControllerAnimated(true, completion: nil)
        }
        catch {
            let saveError = error as NSError
            print("\(saveError), \(saveError.userInfo)")

        }
        
        self.ref.child("user/name").setValue(user.name)
        self.ref.child("user/title").setValue(user.title)
        self.ref.child("user/company").setValue(user.company)
        self.ref.child("user/email").setValue(user.email)
        self.ref.child("user/phone").setValue(user.phone)
        self.ref.child("user/github").setValue(user.github)
        self.ref.child("user/linkedin").setValue(user.linkedin)
        self.ref.child("user/picture").setValue(user.picture)
    }
    
    internal func handleCancelButton() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Prepare View
    private func prepareView() {
        view.backgroundColor  = MaterialColor.white
    }
    
    // Layout View
    private func prepareCardView() {
        
        
        
        let cardView: ImageCardView = ImageCardView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        cardView.cornerRadius = 0
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        scrollView.contentSize = cardView.bounds.size
        scrollView.addSubview(cardView)
        view.addSubview(scrollView)
        
        let switchbutton = MaterialSwitch(state: .On, style: .Default, size:.Large)
        switchbutton.trackOnColor = Color.accentColor1
        switchbutton.buttonOnColor = Color.baseColor1
        switchbutton.buttonOffColor = Color.baseColor1
        cardView.addSubview(switchbutton)

        let shareContact: UILabel = UILabel()
        shareContact.text = "Share Contact"
        shareContact.font = Fonts.title
        shareContact.textColor = MaterialColor.black
        cardView.addSubview(shareContact)

        // prepare icons
        
        let profileView: MaterialView = MaterialView()
        profileView.image = UIImage(named: "photoplaceholder")
        profileView.shape = .Circle
        cardView.addSubview(profileView)
        self.profileView = profileView

        let cameraButton = UIButton()
        cameraButton.backgroundColor = MaterialColor.clear
        cardView.addSubview(cameraButton)
        cameraButton.addTarget(self, action: #selector(handleCameraButton), forControlEvents: .TouchUpInside)

 
        // prepare labels
        
        let photoLabel: UILabel = UILabel()
        photoLabel.text = "Photo"
        photoLabel.font = Fonts.title
        photoLabel.textColor = MaterialColor.black
        cardView.addSubview(photoLabel)

        let nameLabel: UILabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.font = Fonts.title
        nameLabel.textColor = MaterialColor.black
        cardView.addSubview(nameLabel)

        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = Fonts.title
        titleLabel.textColor = MaterialColor.black
        cardView.addSubview(titleLabel)
        
        let companyLabel: UILabel = UILabel()
        companyLabel.text = "Company"
        companyLabel.font = Fonts.title
        companyLabel.textColor = MaterialColor.black
        cardView.addSubview(companyLabel)
        
        let emailLabel: UILabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.font = Fonts.title
        emailLabel.textColor = MaterialColor.black
        cardView.addSubview(emailLabel)
        
        let phoneLabel: UILabel = UILabel()
        phoneLabel.text = "Phone"
        phoneLabel.font = Fonts.title
        phoneLabel.textColor = MaterialColor.black
        cardView.addSubview(phoneLabel)

        let githubLabel: UILabel = UILabel()
        githubLabel.text = "Github"
        githubLabel.font = Fonts.title
        githubLabel.textColor = MaterialColor.black
        cardView.addSubview(githubLabel)
        
        let linkedinLabel: UILabel = UILabel()
        linkedinLabel.text = "Linkedin"
        linkedinLabel.font = Fonts.title
        linkedinLabel.textColor = MaterialColor.black
        cardView.addSubview(linkedinLabel)

        
        // prepare textfields
        // get logged in user name and title from meetup
        //and assign these data to appropriate text fields by default
        let appDelegate = self.appDelegate.dataManager
        appDelegate?.grabUserFromAPI { (userInfo) in
            //print(userInfo["name"])
            self.nameTextField.text = userInfo["name"] as? String
            self.titleTextField.text = userInfo["title"] as? String
        }

        let nameTextfield: UITextField = UITextField()
        nameTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Name",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        nameTextfield.font = Fonts.bodyGrey
        nameTextfield.textAlignment = .Right
        nameTextfield.textColor = Color.greyMedium
        cardView.addSubview(nameTextfield)
        nameTextfield.delegate = self
        //nameTextfield.text = user.name
        self.nameTextField = nameTextfield
        
        

        let titleTextfield: UITextField = UITextField()
        titleTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Title",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        titleTextfield.font = Fonts.bodyGrey
        titleTextfield.textAlignment = .Right
        titleTextfield.textColor = Color.greyMedium
        cardView.addSubview(titleTextfield)
        titleTextfield.delegate = self
        //titleTextfield.text = user.title
        self.titleTextField = titleTextfield

        
        let companyTextfield: UITextField = UITextField()
        companyTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Company",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        companyTextfield.font = Fonts.bodyGrey
        companyTextfield.textAlignment = .Right
        cardView.addSubview(companyTextfield)
        companyTextfield.delegate = self
        self.companyTextField = companyTextfield


        let emailTextfield: UITextField = UITextField()
        emailTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Email",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        emailTextfield.font = Fonts.bodyGrey
        emailTextfield.textAlignment = .Right
        cardView.addSubview(emailTextfield)
        emailTextfield.delegate = self
        self.emailTextField = emailTextfield

        let phoneTextfield: UITextField = UITextField()
        phoneTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Phone",
                                                               attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        phoneTextfield.font = Fonts.bodyGrey
        phoneTextfield.textAlignment = .Right
        phoneTextfield.textColor = Color.greyMedium
        cardView.addSubview(phoneTextfield)
        phoneTextfield.delegate = self
        phoneTextfield.keyboardType = UIKeyboardType.NumberPad
        phoneTextfield.tag = 22
        self.phoneTextField = phoneTextfield


        let githubTextfield: UITextField = UITextField()
        githubTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Github",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        githubTextfield.font = Fonts.bodyGrey
        githubTextfield.textAlignment = .Right
        githubTextfield.textColor = Color.greyMedium
        cardView.addSubview(githubTextfield)
        githubTextfield.delegate = self
        self.githubTextField = githubTextfield

        let linkedinTextfield: UITextField = UITextField()
        linkedinTextfield.attributedPlaceholder = NSAttributedString(string:"Enter LinkedIn",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        linkedinTextfield.font = MaterialFont.systemFontWithSize(13)
        linkedinTextfield.textAlignment = .Right
        linkedinTextfield.textColor = Color.greyMedium
        cardView.addSubview(linkedinTextfield)
        linkedinTextfield.delegate = self
        self.linkedinTextField = linkedinTextfield

        // layout elements
        
        switchbutton.grid.rows = 1
        switchbutton.grid.columns = 2
        switchbutton.grid.offset.columns = 10
        
        profileView.grid.rows = 1
        profileView.grid.columns = 2
        profileView.grid.offset.rows = 1
        profileView.grid.offset.columns = 10
        
        cameraButton.grid.rows = 1
        cameraButton.grid.columns = 7
        cameraButton.grid.offset.rows = 1
        cameraButton.grid.offset.columns = 5
        
        shareContact.grid.rows = 1
        shareContact.grid.columns = 5
        
        photoLabel.grid.rows = 1
        photoLabel.grid.columns = 5
        photoLabel.grid.offset.rows = 1

        nameLabel.grid.rows = 1
        nameLabel.grid.columns = 5
        nameLabel.grid.offset.rows = 2

        titleLabel.grid.rows = 1
        titleLabel.grid.columns = 5
        titleLabel.grid.offset.rows = 3
        
        companyLabel.grid.rows = 1
        companyLabel.grid.columns = 5
        companyLabel.grid.offset.rows = 4
        
        emailLabel.grid.rows = 1
        emailLabel.grid.columns = 5
        emailLabel.grid.offset.rows = 5
        
        phoneLabel.grid.rows = 1
        phoneLabel.grid.columns = 3
        phoneLabel.grid.offset.rows = 6
        
        githubLabel.grid.rows = 1
        githubLabel.grid.columns = 5
        githubLabel.grid.offset.rows = 7
        
        linkedinLabel.grid.rows = 1
        linkedinLabel.grid.columns = 5
        linkedinLabel.grid.offset.rows = 8
        
        nameTextfield.grid.rows = 1
        nameTextfield.grid.columns = 8
        nameTextfield.grid.offset.rows = 2
        nameTextfield.grid.offset.columns = 4

        titleTextfield.grid.rows = 1
        titleTextfield.grid.columns = 8
        titleTextfield.grid.offset.rows = 3
        titleTextfield.grid.offset.columns = 4

        companyTextfield.grid.rows = 1
        companyTextfield.grid.columns = 8
        companyTextfield.grid.offset.rows = 4
        companyTextfield.grid.offset.columns = 4

        emailTextfield.grid.rows = 1
        emailTextfield.grid.columns = 8
        emailTextfield.grid.offset.rows = 5
        emailTextfield.grid.offset.columns = 4

        phoneTextfield.grid.rows = 1
        phoneTextfield.grid.columns = 8
        phoneTextfield.grid.offset.rows = 6
        phoneTextfield.grid.offset.columns = 4
        
        githubTextfield.grid.rows = 1
        githubTextfield.grid.columns = 8
        githubTextfield.grid.offset.rows = 7
        githubTextfield.grid.offset.columns = 4

        linkedinTextfield.grid.rows = 1
        linkedinTextfield.grid.columns = 8
        linkedinTextfield.grid.offset.rows = 8
        linkedinTextfield.grid.offset.columns = 4
        
        cardView.grid.spacing = 2
        cardView.grid.axis.direction = .None
        cardView.grid.contentInsetPreset = .Square3
        cardView.grid.views = [
            switchbutton,
            profileView,
            cameraButton,
            
            photoLabel,
            shareContact,
            profileView,
            nameLabel,
            titleLabel,
            companyLabel,
            emailLabel,
            phoneLabel,
            githubLabel,
            linkedinLabel,
            
            nameTextfield,
            titleTextfield,
            companyTextfield,
            emailTextfield,
            phoneTextfield,
            githubTextfield,
            linkedinTextfield,
            
        ]
    }
    
    // Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.title = "Profile"
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.textColor = Color.accentColor1
        navigationItem.titleLabel.font = Fonts.navigationTitle
        navigationItem.rightControls = [saveButton]
        navigationItem.leftControls = [cancelButton]
    }
    
    // Prepares the navigationBar.
    private func prepareNavigationBar() {
        /**
         To control this setting, set the "View controller-based status bar appearance"
         to "NO" in the info.plist.
         */
        navigationController?.navigationBar.statusBarStyle = .LightContent
        navigationController?.navigationBar.backgroundColor = Color.baseColor1
    }
    
    // Handle Camera Button
    func handleCameraButton(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    /// Save Picture
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let pickedImage: UIImage = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
        profileView.contentMode = .ScaleAspectFit
        profileView.image = pickedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // Dismiss Image Picker
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Format phone number
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        if (textField.tag == 22)
        {
            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            let decimalString = components.joinWithSeparator("") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (1 as unichar)
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
            {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            if hasLeadingOne
            {
                formattedString.appendString("1 ")
                index += 1
            }
            if (length - index) > 3
            {
                let areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            if length - index > 3
            {
                let prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            let remainder = decimalString.substringFromIndex(index)
            formattedString.appendString(remainder)
            textField.text = formattedString as String
            return false
        }
        else
        {
            return true
        }
    }

    private func removeNonNumericCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
}
