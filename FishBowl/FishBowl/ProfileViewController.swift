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

private var saveButton: UIBarButtonItem!
private var cancelButton: UIBarButtonItem!
private var scrollView: UIScrollView = UIScrollView()
private var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()


class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let picker = UIImagePickerController()
    var userID: String?
    var downloadURl: String? = ""
    var userData: NSDictionary = [:]
    
    var activeField: UITextField?
    var profileView: UIImageView!
    var nameTextField : UITextField!
    var titleTextField : UITextField!
    var companyTextField : UITextField!
    var emailTextField : UITextField!
    var phoneTextField : UITextField!
    var githubTextField : UITextField!
    var linkedinTextField : UITextField!
    var ref: FIRDatabaseReference!
    let storage = FIRStorage.storage()
    
    //    viewDid Load
    override func viewDidLoad() {
        super.viewDidLoad()
        //start create database reference
        self.ref = FIRDatabase.database().reference()
        
        prepareView()
        prepareCardView()
        prepareSaveButton()
        prepareCancelButton()
        prepareNavigationItem()
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
        let contentInsets = UIEdgeInsetsMake(0, 0, -200, 0);
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    //    Prepare and Handle Save Button
    private func prepareSaveButton() {
        saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(handleSaveButton))
        saveButton.tintColor = Color.accentColor1
        saveButton.setTitleTextAttributes([
            NSFontAttributeName: Fonts.pinkTitle,
            NSForegroundColorAttributeName: MaterialColor.pink.accent2],
                                          forState: UIControlState.Normal)
    }

    private func prepareCancelButton() {
        cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(handleCancelButton))
        cancelButton.tintColor = Color.accentColor1
        cancelButton.setTitleTextAttributes([
            NSFontAttributeName: Fonts.pinkTitle,
            NSForegroundColorAttributeName: MaterialColor.pink.accent2],
                                          forState: UIControlState.Normal)
    }

    //handle save and cancel button
    func handleSaveButton() {
        //update same user in core data
        if let userInfo: User = self.fetchUserDetails(self.userID!) {
            userInfo.setValue(self.userID, forKey: "userID")
            userInfo.setValue(nameTextField.text, forKey: "name")
            userInfo.setValue(emailTextField.text, forKey: "email")
            userInfo.setValue(companyTextField.text, forKey: "company")
            userInfo.setValue(removeNonNumericCharsFromString(phoneTextField.text!), forKey: "phone")
            userInfo.setValue(UIImageJPEGRepresentation(self.profileView.image!, 1.0), forKey: "picture")
            userInfo.setValue(githubTextField.text, forKey: "github")
            userInfo.setValue(linkedinTextField.text, forKey: "linkedin")
            userInfo.setValue(titleTextField.text, forKey: "title")
            
            let storageRef = storage.referenceForURL("gs://fishbowl-e82eb.appspot.com")
            let imageRef = storageRef.child("images").child("\(self.userID!).png")
            
            
            imageRef.putData(userInfo.picture!, metadata: nil) {
                metadata, error in
                if (error != nil) {
                    print(error)
                }
                self.downloadURl = String(metadata!.downloadURL()!)
                print(self.downloadURl)
                
                self.userData = ["id":userInfo.userID,
                                 "name":userInfo.name!,
                                 "title":userInfo.title!,
                                 "company":userInfo.company!,
                                 "imageData":self.downloadURl!,
                                 "email":userInfo.email!,
                                 "phone":userInfo.phone!,
                                 "github":userInfo.github!,
                                 "linkedin":userInfo.linkedin!]
                
                self.ref.child("users").child(userInfo.userID).setValue(self.userData)
            }
            
            do {
                //save
                try userInfo.managedObjectContext?.save()
                dismissViewControllerAnimated(true, completion: nil)
            }
            catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
            }
        }
        //if there is no such user in core data then create new one
        else {
            let context = self.appDelegate.managedObjectContext
            let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as! User
            user.userID = self.userID!
            user.name = nameTextField.text
            user.title = titleTextField.text
            user.company = companyTextField.text
            user.email = emailTextField.text
            user.phone = removeNonNumericCharsFromString(phoneTextField.text!)
            user.github = githubTextField.text
            user.linkedin = linkedinTextField.text
            user.picture = UIImageJPEGRepresentation(self.profileView.image!, 1.0)
            
            let storageRef = storage.referenceForURL("gs://fishbowl-e82eb.appspot.com")
            let imageRef = storageRef.child("images").child("photoplaceholder.png")
            
            imageRef.putData(user.picture!, metadata: nil) {
                metadata, error in
                if (error != nil) {
                    print(error)
                }
                
                self.downloadURl = String(metadata!.downloadURL()!)
                print(self.downloadURl)
                
                self.userData = ["id":user.userID,
                                 "name":user.name!,
                                 "title":user.title!,
                                 "company":user.company!,
                                 "email":user.email!,
                                 "phone":user.phone!,
                                 "imageData":self.downloadURl!,
                                 "github":user.github!,
                                 "linkedin":user.linkedin!]
                
                let key = self.ref.child("users").child("\(user.userID)").key
                let childUpdate = ["users/\(key)":self.userData]
                self.ref.updateChildValues(childUpdate)
            }
            
            do {
                //save
                try user.managedObjectContext?.save()
                dismissViewControllerAnimated(true, completion: nil)
            }
            catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
            }

        }
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
        cardView.pulseAnimation = .None
        scrollView = UIScrollView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height-44))
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        scrollView.contentSize = cardView.bounds.size
        scrollView.bounces = false
        scrollView.addSubview(cardView)
        view.addSubview(scrollView)
        
        // prepare labels and buttons
        
        
        let photoLabel: UILabel = UILabel(frame:CGRect(x: 20 , y: 20, width: 50, height: 30))
        photoLabel.text = "Photo"
        photoLabel.font = Fonts.title
        photoLabel.textColor = MaterialColor.black
        cardView.addSubview(photoLabel)
        
        let profileView: UIImageView = UIImageView(frame:CGRect(x: view.frame.width - 80 - 20 , y: 15, width: 80, height: 80))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 40.0
        profileView.image = UIImage(named: "photoplaceholder")
        cardView.addSubview(profileView)
        self.profileView = profileView
        
        let cameraButton = UIButton(frame:CGRect(x: view.frame.width - 80 - 20 , y: 15, width: 80, height: 80))
        cameraButton.backgroundColor = MaterialColor.clear
        cardView.addSubview(cameraButton)
        cameraButton.addTarget(self, action: #selector(handleCameraButton), forControlEvents: .TouchUpInside)
        
        let nameLabel: UILabel = UILabel(frame:CGRect(x: 20 , y: 120, width: 100, height: 30))
        nameLabel.text = "Name"
        nameLabel.font = Fonts.title
        nameLabel.textColor = MaterialColor.black
        cardView.addSubview(nameLabel)
        
        let titleLabel: UILabel = UILabel(frame:CGRect(x: 20 , y: 170, width: 100, height: 30))
        titleLabel.text = "Title"
        titleLabel.font = Fonts.title
        titleLabel.textColor = MaterialColor.black
        cardView.addSubview(titleLabel)
        
        let companyLabel: UILabel = UILabel(frame:CGRect(x: 20 , y: 220, width: 100, height: 30))
        companyLabel.text = "Company"
        companyLabel.font = Fonts.title
        companyLabel.textColor = MaterialColor.black
        cardView.addSubview(companyLabel)
        
        let emailLabel: UILabel = UILabel(frame:CGRect(x: 20 , y: 270, width: 100, height: 30))
        emailLabel.text = "Email"
        emailLabel.font = Fonts.title
        emailLabel.textColor = MaterialColor.black
        cardView.addSubview(emailLabel)
        
        let phoneLabel: UILabel = UILabel(frame:CGRect(x: 20 , y: 320, width: 100, height: 30))
        phoneLabel.text = "Phone"
        phoneLabel.font = Fonts.title
        phoneLabel.textColor = MaterialColor.black
        cardView.addSubview(phoneLabel)
        
        let githubLabel: UILabel = UILabel(frame:CGRect(x: 20 , y: 370, width: 100, height: 30))
        githubLabel.text = "Github"
        githubLabel.font = Fonts.title
        githubLabel.textColor = MaterialColor.black
        cardView.addSubview(githubLabel)
        
        let linkedinLabel: UILabel = UILabel(frame:CGRect(x: 20 , y: 420, width: 100, height: 30))
        linkedinLabel.text = "Linkedin"
        linkedinLabel.font = Fonts.title
        linkedinLabel.textColor = MaterialColor.black
        cardView.addSubview(linkedinLabel)
        
        // prepare textfields
        // get logged in user name and title from meetup
        //and assign these data to appropriate text fields by default
        let appDelegate = self.appDelegate.dataManager
        appDelegate?.grabUserFromAPI { (userInfo) in
            
            self.userID = userInfo["id"] as? String
            print(self.userID)
            
            let user = self.fetchUserDetails(self.userID!)
            print(user)
            if user?.userID != nil {
                self.nameTextField.text = user?.name
                self.titleTextField.text = user?.title
                self.companyTextField.text = user?.company
                self.emailTextField.text = user?.email
                self.phoneTextField.text = user?.phone
                self.githubTextField.text = user?.github
                self.linkedinTextField.text = user?.linkedin
                self.profileView.image = UIImage(data:(user?.picture!)!)
            }
            self.nameTextField.text = userInfo["name"] as? String
            
        }
        
        let nameTextfield: UITextField = UITextField(frame:CGRect(x:120 , y: 120, width: view.frame.width - 140, height: 30))
        nameTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Name",
                                                                 attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        nameTextfield.font = Fonts.bodyGrey
        nameTextfield.textAlignment = .Right
        nameTextfield.textColor = Color.greyMedium
        cardView.addSubview(nameTextfield)
        nameTextfield.delegate = self
        self.nameTextField = nameTextfield
        
        
        
        let titleTextfield: UITextField = UITextField(frame:CGRect(x:120 , y: 170, width: view.frame.width - 140, height: 30))
        titleTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Title",
                                                                 attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        titleTextfield.font = Fonts.bodyGrey
        titleTextfield.textAlignment = .Right
        titleTextfield.textColor = Color.greyMedium
        cardView.addSubview(titleTextfield)
        titleTextfield.delegate = self
        //titleTextfield.text = user.title
        self.titleTextField = titleTextfield
        
        
        let companyTextfield: UITextField = UITextField(frame:CGRect(x:120 , y: 220, width: view.frame.width - 140, height: 30))
        companyTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Company",
                                                                    attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        companyTextfield.font = Fonts.bodyGrey
        companyTextfield.textAlignment = .Right
        companyTextfield.textColor = Color.greyMedium
        cardView.addSubview(companyTextfield)
        companyTextfield.delegate = self
        self.companyTextField = companyTextfield
        
        
        let emailTextfield: UITextField = UITextField(frame:CGRect(x:90 , y: 270, width: view.frame.width - 110, height: 30))
        emailTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Email",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        emailTextfield.font = Fonts.bodyGrey
        emailTextfield.textAlignment = .Right
        emailTextfield.autocapitalizationType = UITextAutocapitalizationType.None
        emailTextfield.textColor = Color.greyMedium
        cardView.addSubview(emailTextfield)
        emailTextfield.delegate = self
        self.emailTextField = emailTextfield
        
        let phoneTextfield: UITextField = UITextField(frame:CGRect(x:90 , y: 320, width: view.frame.width - 110, height: 30))
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
        
        
        let githubTextfield: UITextField = UITextField(frame:CGRect(x:90 , y: 370, width: view.frame.width - 110, height: 30))
        githubTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Github",
                                                                   attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        githubTextfield.font = Fonts.bodyGrey
        githubTextfield.textAlignment = .Right
        githubTextfield.autocapitalizationType = UITextAutocapitalizationType.None
        githubTextfield.textColor = Color.greyMedium
        cardView.addSubview(githubTextfield)
        githubTextfield.delegate = self
        self.githubTextField = githubTextfield
        
        let linkedinTextfield: UITextField = UITextField(frame:CGRect(x:90 , y: 420, width: view.frame.width - 110, height: 30))
        linkedinTextfield.attributedPlaceholder = NSAttributedString(string:"Enter LinkedIn",
                                                                     attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        linkedinTextfield.font = Fonts.bodyGrey
        linkedinTextfield.textAlignment = .Right
        linkedinTextfield.autocapitalizationType = UITextAutocapitalizationType.None
        linkedinTextfield.textColor = Color.greyMedium
        cardView.addSubview(linkedinTextfield)
        linkedinTextfield.delegate = self
        self.linkedinTextField = linkedinTextfield

    }
    
    // Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.title = "Profile"
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.textColor = Color.accentColor1
        navigationItem.titleLabel.font = Fonts.navigationTitle
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    // Handle Camera Button
    func handleCameraButton(){
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertView()
            alert.title = "Warning"
            alert.message = "You don't have camera"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
    func openGallery(){
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)
    }

    
    /// Save Picture
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let pickedImage: UIImage = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
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
    
    private func fetchUserDetails(Id: String)->User? {
        let moc = appDelegate.managedObjectContext
        
        //create fetch request
        let fetchRequest = NSFetchRequest()
        
        //create entuity description
        let entityDescription = NSEntityDescription.entityForName("User", inManagedObjectContext: moc)
        let predicate = NSPredicate(format: "userID == %@", Id)
        
        //assign fetch request properties
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        fetchRequest.fetchBatchSize = 1
        fetchRequest.fetchLimit = 1
        fetchRequest.returnsObjectsAsFaults = false
        
        //Execute Fetch Request
        do {
            let result = try moc.executeFetchRequest(fetchRequest).first as? User
            print(result)
            return result
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return nil
    }
}
