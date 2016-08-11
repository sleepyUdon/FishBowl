

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
    public lazy var defaultDate: UILabel = UILabel()
    public lazy var menumodel: MenuModel = MenuModel()
//    var dataManager: DataManager = DataManager()
    
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
        prepareDefaultDate()

    }
    
    /*
    @name   layoutSubviews
    */
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutDefaultLabel()
        layoutDefaultDescription()
        layoutDefaultParticipants()
        layoutDefaultDate()

    }
    
    /*
    @name   prepareDefaultImageView
    */
    public func prepareDefaultImageView() { // I dont' know what this is for
        defaultImageView.backgroundColor = UIColor.clearColor()
        defaultImageView.clipsToBounds = true
        contentView.addSubview(defaultImageView)
    }
    
    /*
    @name   prepareDefaultLabel
    */
    public func prepareDefaultLabel() { // This should be changed to titleLabel
        defaultLabel.font = UIFont.systemFontOfSize(12.0)
        defaultLabel.text = ""
        defaultLabel.textColor = MaterialColor.grey.lighten2
        defaultLabel.textAlignment = .Left
        addSubview(defaultLabel)
    }
    
    
    /*
     @name   prepareDefaultDescription
     */
    public func prepareDefaultDescription() { // This should be changed to groupLabel
        defaultDescription.font = UIFont.systemFontOfSize(12.0)
        defaultDescription.text = ""
        defaultDescription.textColor = MaterialColor.black
        defaultDescription.textAlignment = .Left
        addSubview(defaultDescription)
    }
    
    //#ADDDATE VIV add a label for date in upper right corner
    
    /*
     @name   prepareDefaultParticipants
     */
    public func prepareDefaultParticipants() { // This should be changed to dateLabel
        defaultParticipants.font = UIFont.systemFontOfSize(12.0)
        defaultParticipants.text = ""
        defaultParticipants.textColor = MaterialColor.grey.lighten2
        defaultParticipants.textAlignment = .Left
        addSubview(defaultParticipants)
    }
    
    
    /*
     @name   prepareDefaultDate
     */

    public func prepareDefaultDate() {
        defaultDate.font = UIFont(name: "Avenir", size: 14)
//        let date = menumodel.events["Event1"]
        defaultDate.text = "date" //#PASSDATA date from events
        defaultDate.textColor = MaterialColor.grey.darken2
        defaultDate.textAlignment = .Left
        addSubview(defaultDate)
    }
    
    /*
    @name   layout labels
    */
    
    public func layoutDefaultLabel() {
        let x = CGFloat(50.0)
        let y = (contentView.bounds.size.height / 8) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        defaultLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    public func layoutDefaultDescription() {
        let x = CGFloat(50.0)
        let y = (contentView.bounds.size.height / 8 * 3) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        defaultDescription.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    

    public func layoutDefaultParticipants() {
        let x = CGFloat(50.0)
        let y = (contentView.bounds.size.height / 8 * 5) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        defaultParticipants.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    
    public func layoutDefaultDate() {
        let x = CGFloat(50.0)
        let y = (contentView.bounds.size.height / 8 * 7) - (15.0)
        let w = CGFloat(200.0)
        let h = CGFloat(30.0)
        defaultDate.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
 

}
