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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let picker = UIImagePickerController()
    var userID: String?
    
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
        prepareNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOnScreen), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOffScreen), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //    Setup Keyboard an textfields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardOnScreen(_ notification: Notification){
        let info: NSDictionary  = (notification as NSNotification).userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject).cgRectValue.size
        let contentInsets:UIEdgeInsets  = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
        //you may not need to scroll, see if the active field is already visible
        if (!aRect.contains(activeField!.frame.origin) ) {
            let scrollPoint:CGPoint = CGPoint(x: 0.0, y: activeField!.frame.origin.y - kbSize.height)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
        
    }
    
    func keyboardOffScreen(_ notification: Notification){
        let contentInsets = UIEdgeInsetsMake(0, 0, -200, 0);
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    //    Prepare and Handle Save Button
    fileprivate func prepareSaveButton() {
        saveButton = MaterialButton()
        saveButton.setTitle("Save", for: UIControlState())
        saveButton.setTitleColor(Color.accentColor1, for: UIControlState())
        saveButton.pulseColor = Color.accentColor1
        saveButton.titleLabel!.font = Fonts.title
        saveButton.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
    }

    fileprivate func prepareCancelButton() {
        cancelButton = MaterialButton()
        cancelButton.setTitle("Cancel", for: UIControlState())
        cancelButton.setTitleColor(Color.accentColor1, for: UIControlState())
        cancelButton.pulseColor = Color.accentColor1
        cancelButton.titleLabel!.font = Fonts.title
        cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)

    }

    //handle save and cancel button
    func handleSaveButton() {
        print(self.userID)
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
            
            //let key = ref.child()
            
//            self.ref.child("user/id").setValue(userInfo.userID)
//            self.ref.child("user/name").setValue(userInfo.name)
//            self.ref.child("user/title").setValue(userInfo.title)
//            self.ref.child("user/company").setValue(userInfo.company)
//            self.ref.child("user/email").setValue(userInfo.email)
//            self.ref.child("user/phone").setValue(userInfo.phone)
//            self.ref.child("user/github").setValue(userInfo.github)
//            self.ref.child("user/linkedin").setValue(userInfo.linkedin)
//            self.ref.child("user/picture").setValue(userInfo.picture)
            
            do {
                //save
                try userInfo.managedObjectContext?.save()
                dismiss(animated: true, completion: nil)
            }
            catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
            }
        }
        //if there is no such user in core data then create new one
        else {
            let context = self.appDelegate.managedObjectContext
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            user.userID = self.userID!
            user.name = nameTextField.text
            user.title = titleTextField.text
            user.company = companyTextField.text
            user.email = emailTextField.text
            user.phone = removeNonNumericCharsFromString(phoneTextField.text!)
            user.github = githubTextField.text
            user.linkedin = linkedinTextField.text
            user.picture = UIImageJPEGRepresentation(self.profileView.image!, 1.0)
            
//            self.ref.child("users").child(user.userID).setValue(user.userID)
//            self.ref.child("user/name").setValue(user.name)
//            self.ref.child("user/title").setValue(user.title)
//            self.ref.child("user/company").setValue(user.company)
//            self.ref.child("user/email").setValue(user.email)
//            self.ref.child("user/phone").setValue(user.phone)
//            self.ref.child("user/github").setValue(user.github)
//            self.ref.child("user/linkedin").setValue(user.linkedin)
//            self.ref.child("user/picture").setValue(user.picture)
            
            do {
                //save
                try user.managedObjectContext?.save()
                dismiss(animated: true, completion: nil)
            }
            catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
            }

        }
    }
    
    internal func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // Prepare View
    fileprivate func prepareView() {
        view.backgroundColor  = MaterialColor.white
    }
    
    // Layout View
    fileprivate func prepareCardView() {
  
        let cardView: ImageCardView = ImageCardView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        cardView.pulseAnimation = .none
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height-44))
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        scrollView.contentSize = cardView.bounds.size
        scrollView.bounces = false
        scrollView.addSubview(cardView)
        view.addSubview(scrollView)
        
        // prepare labels and buttons
        
        let shareContact: UILabel = UILabel(frame:CGRect(x: 20.0, y: 20.0, width: view.frame.width/2, height: 30))
        shareContact.text = "Share Contact"
        shareContact.font = Fonts.title
        shareContact.textColor = MaterialColor.black
        cardView.addSubview(shareContact)
        
        let switchbutton = MaterialSwitch(state: .on, style: .default, size: .large)
        switchbutton.frame = CGRect(x: view.frame.width-20-50, y: 20, width: 50, height: 30)
        switchbutton.trackOnColor = Color.accentColor1
        switchbutton.buttonOnColor = Color.baseColor1
        switchbutton.buttonOffColor = Color.baseColor1
        cardView.addSubview(switchbutton)
        
        let photoLabel: UILabel = UILabel(frame:CGRect(x: 20 , y: 70, width: 50, height: 30))
        photoLabel.text = "Photo"
        photoLabel.font = Fonts.title
        photoLabel.textColor = MaterialColor.black
        cardView.addSubview(photoLabel)
        
        let profileView: UIImageView = UIImageView(frame:CGRect(x: view.frame.width - 50 - 20 , y: 65, width: 50, height: 50))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 25.0
        profileView.image = UIImage(named: "photoplaceholder")
        cardView.addSubview(profileView)
        self.profileView = profileView
        
        let cameraButton = UIButton(frame:CGRect(x: view.frame.width - 50 - 20 , y: 70, width: 50, height: 50))
        cameraButton.backgroundColor = MaterialColor.clear
        cardView.addSubview(cameraButton)
        cameraButton.addTarget(self, action: #selector(handleCameraButton), for: .touchUpInside)
        
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
            }
            self.nameTextField.text = userInfo["name"] as? String
            self.titleTextField.text = userInfo["title"] as? String
            
        }
        
        let nameTextfield: UITextField = UITextField(frame:CGRect(x:120 , y: 120, width: view.frame.width - 140, height: 30))
        nameTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Name",
                                                                 attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        nameTextfield.font = Fonts.bodyGrey
        nameTextfield.textAlignment = .right
        nameTextfield.textColor = Color.greyMedium
        cardView.addSubview(nameTextfield)
        nameTextfield.delegate = self
        //nameTextfield.text = user.name
        self.nameTextField = nameTextfield
        
        
        
        let titleTextfield: UITextField = UITextField(frame:CGRect(x:120 , y: 170, width: view.frame.width - 140, height: 30))
        titleTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Title",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        titleTextfield.font = Fonts.bodyGrey
        titleTextfield.textAlignment = .right
        titleTextfield.textColor = Color.greyMedium
        cardView.addSubview(titleTextfield)
        titleTextfield.delegate = self
        //titleTextfield.text = user.title
        self.titleTextField = titleTextfield
        
        
        let companyTextfield: UITextField = UITextField(frame:CGRect(x:120 , y: 220, width: view.frame.width - 140, height: 30))
        companyTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Company",
                                                                    attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        companyTextfield.font = Fonts.bodyGrey
        companyTextfield.textAlignment = .right
        companyTextfield.textColor = Color.greyMedium
        cardView.addSubview(companyTextfield)
        companyTextfield.delegate = self
        self.companyTextField = companyTextfield
        
        
        let emailTextfield: UITextField = UITextField(frame:CGRect(x:90 , y: 270, width: view.frame.width - 110, height: 30))
        emailTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Email",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        emailTextfield.font = Fonts.bodyGrey
        emailTextfield.textAlignment = .right
        emailTextfield.autocapitalizationType = UITextAutocapitalizationType.none
        emailTextfield.textColor = Color.greyMedium
        cardView.addSubview(emailTextfield)
        emailTextfield.delegate = self
        self.emailTextField = emailTextfield
        
        let phoneTextfield: UITextField = UITextField(frame:CGRect(x:90 , y: 320, width: view.frame.width - 110, height: 30))
        phoneTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Phone",
                                                                  attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        phoneTextfield.font = Fonts.bodyGrey
        phoneTextfield.textAlignment = .right
        phoneTextfield.textColor = Color.greyMedium
        cardView.addSubview(phoneTextfield)
        phoneTextfield.delegate = self
        phoneTextfield.keyboardType = UIKeyboardType.numberPad
        phoneTextfield.tag = 22
        self.phoneTextField = phoneTextfield
        
        
        let githubTextfield: UITextField = UITextField(frame:CGRect(x:90 , y: 370, width: view.frame.width - 110, height: 30))
        githubTextfield.attributedPlaceholder = NSAttributedString(string:"Enter Github",
                                                                   attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        githubTextfield.font = Fonts.bodyGrey
        githubTextfield.textAlignment = .right
        githubTextfield.autocapitalizationType = UITextAutocapitalizationType.none
        githubTextfield.textColor = Color.greyMedium
        cardView.addSubview(githubTextfield)
        githubTextfield.delegate = self
        self.githubTextField = githubTextfield
        
        let linkedinTextfield: UITextField = UITextField(frame:CGRect(x:90 , y: 420, width: view.frame.width - 110, height: 30))
        linkedinTextfield.attributedPlaceholder = NSAttributedString(string:"Enter LinkedIn",
                                                                     attributes:[NSForegroundColorAttributeName: MaterialColor.grey.lighten3])
        linkedinTextfield.font = Fonts.bodyGrey
        linkedinTextfield.textAlignment = .right
        linkedinTextfield.autocapitalizationType = UITextAutocapitalizationType.none
        linkedinTextfield.textColor = Color.greyMedium
        cardView.addSubview(linkedinTextfield)
        linkedinTextfield.delegate = self
        self.linkedinTextField = linkedinTextfield

    }
    
    // Prepares the navigationItem.
    fileprivate func prepareNavigationItem() {
        navigationItem.title = "Profile"
        navigationItem.titleLabel.textAlignment = .center
        navigationItem.titleLabel.textColor = Color.accentColor1
        navigationItem.titleLabel.font = Fonts.navigationTitle
        navigationItem.rightControls = [saveButton]
        navigationItem.leftControls = [cancelButton]
    }
    
    // Prepares the navigationBar.
    fileprivate func prepareNavigationBar() {
        /**
         To control this setting, set the "View controller-based status bar appearance"
         to "NO" in the info.plist.
         */
        navigationController?.navigationBar.statusBarStyle = .lightContent
        navigationController?.navigationBar.backgroundColor = Color.baseColor1
    }
    
    // Handle Camera Button
    func handleCameraButton(){
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertView()
            alert.title = "Warning"
            alert.message = "You don't have camera"
            alert.addButton(withTitle: "OK")
            alert.show()
        }
    }
    func openGallery(){
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }

    
    /// Save Picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage: UIImage = (info as NSDictionary).object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        profileView.image = pickedImage
        self.dismiss(animated: true, completion: nil)
    }

    // Dismiss Image Picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Format phone number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField.tag == 22)
        {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = newString.components(separatedBy: CharacterSet.decimalDigits.inverted)
            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
            {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            if hasLeadingOne
            {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 3
            {
                let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            if length - index > 3
            {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        }
        else
        {
            return true
        }
    }

    fileprivate func removeNonNumericCharsFromString(_ text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    fileprivate func fetchUserDetails(_ Id: String)->User? {
        let moc = appDelegate.managedObjectContext
        
        //create fetch request
        let fetchRequest = NSFetchRequest()
        
        //create entuity description
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: moc)
        let predicate = NSPredicate(format: "userID == %@", Id)
        
        //assign fetch request properties
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        fetchRequest.fetchBatchSize = 1
        fetchRequest.fetchLimit = 1
        fetchRequest.returnsObjectsAsFaults = false
        
        //Execute Fetch Request
        do {
            let result = try moc.fetch(fetchRequest).first as? User
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
