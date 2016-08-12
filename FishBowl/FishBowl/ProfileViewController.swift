//
//  ProfileViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material

/// NavigationBar save button.
private var saveButton: MaterialButton!
private var scrollView: UIScrollView = UIScrollView()
var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()



class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate {
    
    var activeField: UITextField?
    let profileView: UIImageView = UIImageView() //#IMAGEPICKER VIV add imagepicker for profile picture
    let imagePicker = UIImagePickerController()
//    imagePicker.delegate = self

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSaveButton()
        prepareCardView()
        prepareNavigationItem()
        prepareNavigationBar()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardOnScreen), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardOffScreen), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeField = textField
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
    
    
    
    private func prepareSaveButton() {
        saveButton = MaterialButton()
        saveButton.setTitle("Save", forState: .Normal)
        saveButton.setTitleColor(UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100), forState: .Normal)
        saveButton.pulseColor = MaterialColor.white
        saveButton.titleLabel!.font = UIFont(name: "Avenir", size: 15)
        saveButton.addTarget(self, action: #selector(handleSaveButton), forControlEvents: .TouchUpInside)
    }

    
    /// Handles the saveButton.
    internal func handleSaveButton() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    // Layout View
    
    private func prepareCardView() {
        
        let cardView: ImageCardView = ImageCardView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        cardView.pulseColor = MaterialColor.white
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        scrollView.contentSize = cardView.bounds.size
        scrollView.addSubview(cardView)
        view.addSubview(scrollView)
        
        
        let switchbutton = MaterialSwitch(state: .On, style: .Default, size: .Small)
        switchbutton.trackOnColor = UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100)
        switchbutton.buttonOnColor = MaterialColor.blueGrey.darken4
        switchbutton.buttonOffColor = MaterialColor.blueGrey.darken4
        cardView.addSubview(switchbutton)

        let shareContact: UILabel = UILabel()
        shareContact.text = "Share Contacts"
        shareContact.font = UIFont(name: "Avenir", size: 14)
        shareContact.textColor = MaterialColor.black
        cardView.addSubview(shareContact)

        // prepare icons
        
        let profileView: MaterialView = MaterialView()
        profileView.image = UIImage(named: "VivianeChan")
        profileView.shape = .Circle
        cardView.addSubview(profileView)
        
        let photoView: UIImageView = UIImageView() //#IMAGEPICKER VIV add imagepicker for profile picture
        photoView.image = UIImage(named: "camera")
        photoView.backgroundColor = MaterialColor.white
        cardView.addSubview(photoView)
        
        let cameraButton = UIButton()
        cameraButton.backgroundColor = MaterialColor.clear
        cardView.addSubview(cameraButton)
        cameraButton.addTarget(self, action: #selector(handleCameraButton), forControlEvents: .TouchUpInside)

        
        let nameView: UIImageView = UIImageView()
        nameView.image = UIImage(named: "profile")
        nameView.backgroundColor = MaterialColor.white
        cardView.addSubview(nameView)
        
        let titleView: UIImageView = UIImageView()
        titleView.image = UIImage(named: "profile")
        titleView.backgroundColor = MaterialColor.white
        cardView.addSubview(titleView)
        
        let companyView: UIImageView = UIImageView()
        companyView.image = UIImage(named: "profile")
        companyView.backgroundColor = MaterialColor.white
        cardView.addSubview(companyView)
        
        let emailView: UIImageView = UIImageView()
        emailView.image = UIImage(named: "mail")
        emailView.backgroundColor = MaterialColor.white
        cardView.addSubview(emailView)
        
        let phoneView: UIImageView = UIImageView()
        phoneView.image = UIImage(named: "phone")
        phoneView.backgroundColor = MaterialColor.white
        cardView.addSubview(phoneView)

        let githubView: UIImageView = UIImageView()
        githubView.image = UIImage(named: "github")
        githubView.backgroundColor = MaterialColor.white
        cardView.addSubview(githubView)
        
        let linkedinView: UIImageView = UIImageView()
        linkedinView.image = UIImage(named: "linkedin")
        linkedinView.backgroundColor = MaterialColor.white
        cardView.addSubview(linkedinView)
        
        
        // prepare labels
        
        let photoLabel: UILabel = UILabel()
        photoLabel.text = "Photo"
        photoLabel.font = UIFont(name: "Avenir", size: 14)
        photoLabel.textColor = MaterialColor.black
        cardView.addSubview(photoLabel)

        let nameLabel: UILabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.font = UIFont(name: "Avenir", size: 14)
        nameLabel.textColor = MaterialColor.black
        cardView.addSubview(nameLabel)

        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = UIFont(name: "Avenir", size: 14)
        titleLabel.textColor = MaterialColor.black
        cardView.addSubview(titleLabel)
        
        let companyLabel: UILabel = UILabel()
        companyLabel.text = "Company"
        companyLabel.font = UIFont(name: "Avenir", size: 14)
        companyLabel.textColor = MaterialColor.black
        cardView.addSubview(companyLabel)
        
        let emailLabel: UILabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "Avenir", size: 14)
        emailLabel.textColor = MaterialColor.black
        cardView.addSubview(emailLabel)
        
        let phoneLabel: UILabel = UILabel()
        phoneLabel.text = "Phone"
        phoneLabel.font = UIFont(name: "Avenir", size: 14)
        phoneLabel.textColor = MaterialColor.black
        cardView.addSubview(phoneLabel)

        let githubLabel: UILabel = UILabel()
        githubLabel.text = "Github"
        githubLabel.font = UIFont(name: "Avenir", size: 14)
        githubLabel.textColor = MaterialColor.black
        cardView.addSubview(githubLabel)
        
        let linkedinLabel: UILabel = UILabel()
        linkedinLabel.text = "linkedIn"
        linkedinLabel.font = UIFont(name: "Avenir", size: 14)
        linkedinLabel.textColor = MaterialColor.black
        cardView.addSubview(linkedinLabel)

        
        // prepare textfields
        
        let nameTextfield: UITextField = UITextField()
        nameTextfield.placeholder = "Viviane Chan" //#PASSDATA from user
        nameTextfield.font = UIFont(name: "Avenir", size: 14)
        nameTextfield.textColor = MaterialColor.black
        cardView.addSubview(nameTextfield)
        nameTextfield.delegate = self

        let titleTextfield: UITextField = UITextField()
        titleTextfield.placeholder = "iOS Developer" //#PASSDATA from user
        titleTextfield.font = UIFont(name: "Avenir", size: 14)
        titleTextfield.textColor = MaterialColor.black
        cardView.addSubview(titleTextfield)
        titleTextfield.delegate = self

        
        let companyTextfield: UITextField = UITextField()
        companyTextfield.placeholder = "Lighthouse Labs" //#PASSDATA from user
        companyTextfield.font = UIFont(name: "Avenir", size: 14)
        companyTextfield.textColor = MaterialColor.black
        cardView.addSubview(companyTextfield)
        companyTextfield.delegate = self


        let emailTextfield: UITextField = UITextField()
        emailTextfield.placeholder = "vivianechan@hotmail.com" //#PASSDATA from user
        emailTextfield.font = UIFont(name: "Avenir", size: 14)
        emailTextfield.textColor = MaterialColor.black
        cardView.addSubview(emailTextfield)
        emailTextfield.delegate = self

        let phoneTextfield: UITextField = UITextField() //VIV #PHONEINPUT
        phoneTextfield.placeholder = "(647)836 5162" //#PASSDATA from user
        phoneTextfield.font = UIFont(name: "Avenir", size: 14)
        emailTextfield.textColor = MaterialColor.black
        cardView.addSubview(phoneTextfield)
        phoneTextfield.delegate = self

        let githubTextfield: UITextField = UITextField()
        githubTextfield.placeholder = "github.com/sleepyUdon" //#PASSDATA from user
        githubTextfield.font = UIFont(name: "Avenir", size: 14)
        githubTextfield.textColor = MaterialColor.black
        cardView.addSubview(githubTextfield)
        githubTextfield.delegate = self

        let linkedinTextfield: UITextField = UITextField()
        linkedinTextfield.placeholder = "https://www.linkedin.com/in/vivianechan" //#PASSDATA from user
        linkedinTextfield.font = UIFont(name: "Avenir", size: 14)
        linkedinTextfield.textColor = MaterialColor.black
        cardView.addSubview(linkedinTextfield)
        linkedinTextfield.delegate = self

        
        // layout elements
        
        switchbutton.grid.rows = 1
        switchbutton.grid.columns = 3
        switchbutton.grid.offset.columns = 9
        
        shareContact.grid.rows = 1
        shareContact.grid.columns = 8
        
        photoView.grid.rows = 1
        photoView.grid.columns = 2
        photoView.grid.offset.rows = 1
        photoView.grid.offset.columns = 0
        
        nameView.grid.rows = 1
        nameView.grid.columns = 2
        nameView.grid.offset.rows = 2
        nameView.grid.offset.columns = 0
        
        titleView.grid.rows = 1
        titleView.grid.columns = 2
        titleView.grid.offset.rows = 3
        titleView.grid.offset.columns = 0

        companyView.grid.rows = 1
        companyView.grid.columns = 2
        companyView.grid.offset.rows = 4
        companyView.grid.offset.columns = 0

        emailView.grid.rows = 1
        emailView.grid.columns = 2
        emailView.grid.offset.rows = 5
        emailView.grid.offset.columns = 0

        phoneView.grid.rows = 1
        phoneView.grid.columns = 2
        phoneView.grid.offset.rows = 6
        phoneView.grid.offset.columns = 0

        githubView.grid.rows = 1
        githubView.grid.columns = 2
        githubView.grid.offset.rows = 7
        githubView.grid.offset.columns = 0
        
        linkedinView.grid.rows = 1
        linkedinView.grid.columns = 2
        linkedinView.grid.offset.rows = 8
        linkedinView.grid.offset.columns = 0

        photoLabel.grid.rows = 1
        photoLabel.grid.columns = 5
        photoLabel.grid.offset.rows = 1
        photoLabel.grid.offset.columns = 2
        
        profileView.grid.rows = 1
        profileView.grid.columns = 2
        profileView.grid.offset.rows = 1
        profileView.grid.offset.columns = 5
        
        cameraButton.grid.rows = 1
        cameraButton.grid.columns = 2
        cameraButton.grid.offset.rows = 1
        cameraButton.grid.offset.columns = 5


        nameLabel.grid.rows = 1
        nameLabel.grid.columns = 4
        nameLabel.grid.offset.rows = 2
        nameLabel.grid.offset.columns = 2

        titleLabel.grid.rows = 1
        titleLabel.grid.columns = 4
        titleLabel.grid.offset.rows = 3
        titleLabel.grid.offset.columns = 2
        
        companyLabel.grid.rows = 1
        companyLabel.grid.columns = 4
        companyLabel.grid.offset.rows = 4
        companyLabel.grid.offset.columns = 2
        
        emailLabel.grid.rows = 1
        emailLabel.grid.columns = 4
        emailLabel.grid.offset.rows = 5
        emailLabel.grid.offset.columns = 2
        
        phoneLabel.grid.rows = 1
        phoneLabel.grid.columns = 4
        phoneLabel.grid.offset.rows = 6
        phoneLabel.grid.offset.columns = 2
        
        githubLabel.grid.rows = 1
        githubLabel.grid.columns = 4
        githubLabel.grid.offset.rows = 7
        githubLabel.grid.offset.columns = 2
        
        linkedinLabel.grid.rows = 1
        linkedinLabel.grid.columns = 4
        linkedinLabel.grid.offset.rows = 8
        linkedinLabel.grid.offset.columns = 2
        
        nameTextfield.grid.rows = 1
        nameTextfield.grid.columns = 7
        nameTextfield.grid.offset.rows = 2
        nameTextfield.grid.offset.columns = 5

        titleTextfield.grid.rows = 1
        titleTextfield.grid.columns = 7
        titleTextfield.grid.offset.rows = 3
        titleTextfield.grid.offset.columns = 5

        companyTextfield.grid.rows = 1
        companyTextfield.grid.columns = 7
        companyTextfield.grid.offset.rows = 4
        companyTextfield.grid.offset.columns = 5

        emailTextfield.grid.rows = 1
        emailTextfield.grid.columns = 7
        emailTextfield.grid.offset.rows = 5
        emailTextfield.grid.offset.columns = 5

        phoneTextfield.grid.rows = 1
        phoneTextfield.grid.columns = 7
        phoneTextfield.grid.offset.rows = 6
        phoneTextfield.grid.offset.columns = 5
        
        githubTextfield.grid.rows = 1
        githubTextfield.grid.columns = 7
        githubTextfield.grid.offset.rows = 7
        githubTextfield.grid.offset.columns = 5

        linkedinTextfield.grid.rows = 1
        linkedinTextfield.grid.columns = 8
        linkedinTextfield.grid.offset.rows = 8
        linkedinTextfield.grid.offset.columns = 5

        cardView.grid.spacing = 2
        cardView.grid.axis.direction = .None
        cardView.grid.contentInsetPreset = .Square3
        cardView.grid.views = [
            switchbutton,
            profileView,
            photoView,
            cameraButton,
            nameView,
            titleView,
            companyView,
            emailView,
            phoneView,
            githubView,
            linkedinView,
            
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
            linkedinTextfield
        ]
    }
 
    
    /// Prepares the navigationItem.
    
    private func prepareNavigationItem() {
        navigationItem.title = "Profile"
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.textColor = MaterialColor.white
        navigationItem.titleLabel.font = UIFont(name: "Avenir", size: 15)
        navigationItem.rightControls = [saveButton]

    }
    
    /// Prepares the navigationBar.
    
    private func prepareNavigationBar() {
        /**
         To control this setting, set the "View controller-based status bar appearance"
         to "NO" in the info.plist.
         */
        navigationController?.navigationBar.statusBarStyle = .LightContent
        navigationController?.navigationBar.backgroundColor = MaterialColor.blueGrey.darken4
    }
    
    
    func handleCameraButton(){
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileView.contentMode = .ScaleAspectFit
            profileView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
