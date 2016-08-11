

import UIKit
import Material

public struct DefaultOptions {
    public struct ImageView {
        public struct Padding {
            public static let Vertical = CGFloat(5.0)
            public static let Horizontal = CGFloat(5.0)
        }
    }
    public struct Label {
        public struct Padding {
            public static let Vertical = CGFloat(10.0)
            public static let Horizontal = CGFloat(10.0)
        }
    }
}


public class EventsTableViewCell: UITableViewCell {
    public lazy var defaultImageView: UIImageView = UIImageView()
    public lazy var defaultLabel: UILabel = UILabel()
    public lazy var defaultDescription: UILabel = UILabel()
    public lazy var defaultParticipants: UILabel = UILabel()
    public lazy var menumodel: MenuModel = MenuModel()
    
    /*
    @name   required initWithCoder
    */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    @name   init
    */
    public override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareDefaultLabel()
        prepareDefaultDescription()
        prepareDefaultParticipants()
    }
    
    /*
    @name   layoutSubviews
    */
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutDefaultLabel()
        layoutDefaultDescription()
        layoutDefaultParticipants()
    }
    
    
    /*
    @name   prepareDefaultLabel
    */
    public func prepareDefaultLabel() {
        defaultLabel.font = UIFont(name: "Avenir", size: 14)
        let eventGroup = menumodel.events["Event1"] //#PASSDATA group from events
        defaultLabel.text = eventGroup!["Group"]!
        defaultLabel.textColor = MaterialColor.grey.darken2
        defaultLabel.textAlignment = .Left
        addSubview(defaultLabel)
    }
    
    
    /*
     @name   prepareDefaultDescription
     */
    public func prepareDefaultDescription() {
        defaultDescription.font = UIFont(name: "Avenir-Heavy", size: 14)
        let eventTitle = menumodel.events["Event1"]
        defaultDescription.text = eventTitle!["EventTitle"]! //#PASSDATA description from events
        defaultDescription.textColor = MaterialColor.black
        defaultDescription.textAlignment = .Left
        addSubview(defaultDescription)
    }
    
    //#ADDDATE VIV add a label for date in upper right corner
    
    /*
     @name   prepareDefaultParticipants
     */
    public func prepareDefaultParticipants() {
        defaultParticipants.font = UIFont(name: "Avenir", size: 14)
        let participants = menumodel.events["Event1"]
        defaultParticipants.text = participants!["Participants"]! //#PASSDATA participants from events
        defaultParticipants.textColor = MaterialColor.grey.darken2
        defaultParticipants.textAlignment = .Left
        addSubview(defaultParticipants)
    }
    
    
    /*
    @name   layout labels
    */
    
    public func layoutDefaultLabel() {
        let x = CGFloat(50.0)
        let y = (contentView.bounds.size.height / 6) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        defaultLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    public func layoutDefaultDescription() {
        let x = CGFloat(50.0)
        let y = (contentView.bounds.size.height / 2) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        defaultDescription.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    

    public func layoutDefaultParticipants() {
        let x = CGFloat(50.0)
        let y = (contentView.bounds.size.height / 6 * 5) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        defaultParticipants.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 200.0;//VIV SET ROW HEIGHT!!!!
    }

}
