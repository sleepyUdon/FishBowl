//
//  MenuViewController+UITableViewDelegate.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-11-02.
//  Copyright © 2015 Adam Dahan. All rights reserved.
//

import UIKit
import Material

extension ContactsViewController: UITableViewDelegate {

    /*
    @name   required didSelectRowAtIndexPath
    */
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let destination = EventDetailViewController()
//        navigationController?.pushViewController(destination, animated: true)
//
//        // didSelect
        prepareLargeCardViewExample()

    }

    private func prepareLargeCardViewExample() {
        //        _: UIImage? = UIImage(named: "CosmicMindInverted")
        
        let cardView: MaterialPulseView = MaterialPulseView(frame: CGRect(x: 0, y: 0, width: view.bounds.width-200, height: view.bounds.height-20))
        Layout.horizontally(view, child:cardView)
        Layout.vertically(view, child: cardView)
        cardView.backgroundColor = MaterialColor.pink.lighten1
        cardView.pulseColor = MaterialColor.white
        view.addSubview(cardView)
        
        
        let profileView: MaterialView = MaterialView()
        profileView.image = UIImage(named: "VivianeChan")
        profileView.shape = .Circle
        view.addSubview(profileView)
        
        let nameLabel: UILabel = UILabel()
        nameLabel.text = "VIVIANE CHAN"
        nameLabel.font = UIFont(name: "Avenir", size: 15)
        nameLabel.textColor = MaterialColor.black
        view.addSubview(nameLabel)

        let titleLabel: UILabel = UILabel()
        titleLabel.text = "iOS Developer"
        titleLabel.font = UIFont(name: "Avenir", size: 15)
        titleLabel.textColor = MaterialColor.black
        view.addSubview(titleLabel)
        
        let companyLabel: UILabel = UILabel()
        companyLabel.text = "Lighthouse Labs"
        companyLabel.font = UIFont(name: "Avenir", size: 15)
        nameLabel.textColor = MaterialColor.black
        view.addSubview(companyLabel)
            
        profileView.grid.rows = 4
        profileView.grid.columns = 8
        nameLabel.grid.offset.rows = 2
        profileView.grid.offset.columns = 2
        
        nameLabel.grid.rows = 1
        nameLabel.grid.columns = 12
        nameLabel.grid.offset.rows = 5
        nameLabel.grid.offset.columns = 1
        
        titleLabel.grid.rows = 1
        titleLabel.grid.columns = 12
        titleLabel.grid.offset.rows = 6
        titleLabel.grid.offset.columns = 1
        
        companyLabel.grid.rows = 1
        companyLabel.grid.columns = 12
        companyLabel.grid.offset.rows = 7
        companyLabel.grid.offset.columns = 1
        
        
        cardView.grid.spacing = 2
        cardView.grid.axis.direction = .None
        cardView.grid.contentInsetPreset = .Square3
        cardView.grid.views = [
            profileView,
            nameLabel,
            titleLabel,
            companyLabel
        ]
    }
}

            
    
        
    

    

    

