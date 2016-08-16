

import UIKit
import Material

extension MenuViewController: UITableViewDelegate {

    /*
    @name   required didSelectRowAtIndexPath
     */
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let destination = ParticipantsViewController()
        navigationController?.pushViewController(destination, animated: true)
        destination.navigationItem.title = "Participants"
        destination.navigationItem.titleLabel.textColor = Color.accentColor1
        destination.navigationItem.titleLabel.font = Fonts.navigationTitle
    }
 
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        return cell.height() VIVFIX THIS
        return 100.0
    }
}


