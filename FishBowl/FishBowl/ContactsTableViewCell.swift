
import UIKit
import Material


open class ContactsTableViewCell: UITableViewCell {
    open lazy var profileView: UIImageView = UIImageView()
    open lazy var nameLabel: UILabel = UILabel()
    open lazy var titleLabel: UILabel = UILabel()
    //var dataManager: DataManager!
    
    
    var contact: User! {
        didSet {
            populateCell()
        }
    }
    
    fileprivate func populateCell() {
        print(contact)
        nameLabel.text = contact.name
        titleLabel.text = contact.title
        if contact.picture == nil {
            profileView.image = UIImage(named: "photoplaceholder.png")
        }
        profileView.image = UIImage(data: contact.picture! as Data)
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
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageView()
        layoutNameLabel()
        layoutTitleLabel()
    }
    
    /*
     @name   prepareDefaultImageView
     */
    open func prepareImageView()
 {
    profileView.image = UIImage(named: "photoplaceholder")
    profileView.layer.cornerRadius = profileView.frame.width/2
    profileView.contentMode = .scaleAspectFill
    profileView.backgroundColor = Color.greyDark
    profileView.clipsToBounds = true
    addSubview(profileView)
    }
    
    
    /*
     @name   prepareDefaultLabel
     */
    open func prepareNameLabel() {
        nameLabel.font = Fonts.title
        nameLabel.text = "Name" //#PASSDATA name from participant
        nameLabel.textColor = Color.greyDark
        nameLabel.textAlignment = .left
        addSubview(nameLabel)
    }
    
    
    /*
     @name   prepareDefaultDescription
     */
    open func prepareTitleLabel() {
        titleLabel.font = Fonts.bodyGrey
        titleLabel.text = "Position" //#PASSDATA title from participant
        titleLabel.textColor = Color.greyMedium
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
    }
    
    
    /*
     @name   layoutDefaultImageView
     */
    open func layoutImageView() {
        let x = CGFloat(20.0)
        let y = CGFloat(10.0)
        let w = CGFloat(60.0)
        let h = CGFloat(60.0)
        profileView.frame = CGRect(x: x, y: y, width: w, height: h)
        // FIX ME: Make dynamic
        profileView.layer.cornerRadius = w / 2
        
    }
    
    open func layoutNameLabel() {
        let x = CGFloat(100.0)
        let y = CGFloat(10.0)
        let w = contentView.frame.width - (80.0)
        let h = CGFloat(20.0)
        nameLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    open func layoutTitleLabel() {
        let x = CGFloat(100.0)
        let y = CGFloat(20.0)
        let w = contentView.frame.width - (110.0)
        let h = CGFloat(60.0)
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
}



