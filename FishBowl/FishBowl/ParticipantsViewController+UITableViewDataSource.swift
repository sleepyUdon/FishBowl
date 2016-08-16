

import UIKit

extension ParticipantsViewController: UITableViewDataSource {
    
//    public lazy var menumodel:MenuModel = MenuModel()
    /*
    @name   numberOfSectionsInTableView
    */
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ParticipantsModel.sectionsCount()
    }
    
    /*
    @name   numberOfRowsInSection
    */
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(participantsSearchActive) {
            if filteredParticipants.count == 0{
                return membersData.members.count
            } else {
                return self.filteredParticipants.count
            }
        } else {
            return membersData.members.count
        }
    }
    
    /*
    @name   cellForRowAtIndexPath
    */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ParticipantsTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! ParticipantsTableViewCell
        cell.selectionStyle = .None
        
        if(participantsSearchActive){
            let members = membersData.members
            
            cell.nameLabel.text = filteredParticipants[indexPath.row]
            for member in members
            {if member.memberName == filteredParticipants[indexPath.row] {cell.nameLabel.text = member.memberName
                }}
            
            for member in members
            {if member.memberName == filteredParticipants[indexPath.row] {cell.profileView.image = UIImage(data: member.memberImage!)}}
            
            for member in members
            {if member.memberName == filteredParticipants[indexPath.row] {cell.titleLabel.text = member.memberBio}}
                
        } else {
                
                let members = membersData.members
                let member = members[indexPath.row]
                
                cell.profileView.image = UIImage(data: member.memberImage!)
                cell.titleLabel.text = member.memberBio
                cell.nameLabel.text = member.memberName
        }
        
                return cell
            }
}