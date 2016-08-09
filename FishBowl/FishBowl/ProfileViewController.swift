//
//  ProfileViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material


class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLargeCardViewExample()
        
    }
    
    
    // Layout View
    
    private func prepareLargeCardViewExample() {
        //        _: UIImage? = UIImage(named: "CosmicMindInverted")
        
        let cardView: MaterialPulseView = MaterialPulseView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        cardView.pulseColor = MaterialColor.white
        view.addSubview(cardView)
        
        let shareContact: UILabel = UILabel()
        shareContact.text = "Share Contacts"
        shareContact.font = UIFont(name: "Avenir", size: 15)
        shareContact.textColor = MaterialColor.black
        view.addSubview(shareContact)
        
        let photoLabel: UILabel = UILabel()
        photoLabel.text = "Photo"
        photoLabel.font = UIFont(name: "Avenir", size: 15)
        photoLabel.textColor = MaterialColor.black
        view.addSubview(photoLabel)

        
        let nameLabel: UILabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.font = UIFont(name: "Avenir", size: 15)
        nameLabel.textColor = MaterialColor.black
        view.addSubview(nameLabel)

        shareContact.grid.rows = 1
        shareContact.grid.columns = 8
//        shareContact.grid.offset.rows = 1

        photoLabel.grid.rows = 1
        photoLabel.grid.columns = 8
        photoLabel.grid.offset.rows = 1
        photoLabel.grid.offset.columns = 1

        nameLabel.grid.rows = 1
        nameLabel.grid.columns = 8
        nameLabel.grid.offset.rows = 2
        nameLabel.grid.offset.columns = 1

        
        cardView.grid.spacing = 2
        cardView.grid.axis.direction = .None
        cardView.grid.contentInsetPreset = .Square3
        cardView.grid.views = [
            photoLabel,
            shareContact,
            nameLabel
        ]
    }
    
    internal func handleLoginButton() {
        let eventsViewController = EventsViewController()
        let navc: NavigationController = NavigationController(rootViewController: eventsViewController)
        navc.modalTransitionStyle = .CrossDissolve
        presentViewController(navc, animated: true, completion: nil)
    }
    
}
