
import UIKit
import Material


public class ContactsTableViewCell: UITableViewCell {
    public lazy var profileView: MaterialView = MaterialView()
    public lazy var nameLabel: UILabel = UILabel()
    public lazy var titleLabel: UILabel = UILabel()
    var dataManager: DataManager!
    
    
    var contact: User! {
        didSet {
            populateCell()
        }
    }
    
    private func populateCell() {
        nameLabel.text = contact.name
        titleLabel.text = contact.bio
        profileView.image = UIImage(data: contact.image!)
    }
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
        prepareImageView()
        prepareNameLabel()
        prepareTitleLabel()
    }
    
    /*
     @name   layoutSubviews
     */
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageView()
        layoutNameLabel()
        layoutTitleLabel()
    }
    
    /*
     @name   prepareDefaultImageView
     */
    public func prepareImageView()
 {
    profileView.image = UIImage(named: "photoplaceholder") //#PASSDATA image from participant
    profileView.shape = .Circle
    profileView.backgroundColor = Color.greyDark
    profileView.clipsToBounds = true
    addSubview(profileView)
    }
    
    
    /*
     @name   prepareDefaultLabel
     */
    public func prepareNameLabel() {
        nameLabel.font = Fonts.title
        nameLabel.text = "Name" //#PASSDATA name from participant
        nameLabel.textColor = Color.greyDark
        nameLabel.textAlignment = .Left
        addSubview(nameLabel)
    }
    
    
    /*
     @name   prepareDefaultDescription
     */
    public func prepareTitleLabel() {
        titleLabel.font = Fonts.bodyGrey
        titleLabel.text = "Position" //#PASSDATA title from participant
        titleLabel.textColor = Color.greyMedium
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Left
        addSubview(titleLabel)
    }
    
    
    /*
     @name   layoutDefaultImageView
     */
    public func layoutImageView() {
        let x = CGFloat(20.0)
        let y = CGFloat(10.0)
        let w = CGFloat(60.0)
        let h = CGFloat(60.0)
        profileView.frame = CGRect(x: x, y: y, width: w, height: h)
        // FIX ME: Make dynamic
        profileView.layer.cornerRadius = w / 2
        
    }
    
    public func layoutNameLabel() {
        let x = CGFloat(100.0)
        let y = CGFloat(10.0)
        let w = contentView.frame.width - (80.0)
        let h = CGFloat(20.0)
        nameLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    public func layoutTitleLabel() {
        let x = CGFloat(100.0)
        let y = CGFloat(20.0)
        let w = contentView.frame.width - (110.0)
        let h = CGFloat(60.0)
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
}



