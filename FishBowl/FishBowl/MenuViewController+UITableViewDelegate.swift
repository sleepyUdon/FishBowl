

import UIKit
import Material

extension MenuViewController: UITableViewDelegate {

    /*
    @name   required didSelectRowAtIndexPath
     */
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let event = eventsData.events[indexPath.row]
        appDelegate.dataManager?.eventId = event.eventId
        print(event.eventId)
        let destination = ParticipantsViewController()
        
        navigationController?.pushViewController(destination, animated: false)
        destination.navigationItem.title = "Participants"
        destination.navigationItem.titleLabel.textColor = Color.accentColor1
        destination.navigationItem.titleLabel.font = Fonts.navigationTitle
    }
 
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        return cell.height() VIVFIX THIS
        return 80.0
    }
}


