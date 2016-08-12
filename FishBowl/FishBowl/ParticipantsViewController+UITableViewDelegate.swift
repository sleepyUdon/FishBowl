//
//  ParticipantsDelegate.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-11.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material

extension ParticipantsViewController: UITableViewDelegate {
    
    /*
     @name   required didSelectRowAtIndexPath
     */
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        let cell = tableView.cellForRowAtIndexPath(indexPath)
        //        return cell.height() VIVFIX THIS
        return 80
    }
    
}

