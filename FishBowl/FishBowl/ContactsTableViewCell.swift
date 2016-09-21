
import UIKit
import Material


public class ContactsTableViewCell: UITableViewCell {
    public lazy var profileView: UIImageView = UIImageView()
    public lazy var nameLabel: UILabel = UILabel()
    public lazy var companyLabel: UILabel = UILabel()
    public lazy var titleLabel: UILabel = UILabel()
    //var dataManager: DataManager!
    
    
    var contact: User! {
        didSet {
            populateCell()
        }
    }
    
    private func populateCell() {
        print(contact)
        nameLabel.text = contact.name
        if companyLabel.text == nil {
            companyLabel.text = ""
        }
        companyLabel.text = contact.company
        
        if titleLabel.text == nil {
            titleLabel.text = ""
        }
        titleLabel.text = contact.title
        
        if contact.picture == nil {
            profileView.image = UIImage(named: "photoplaceholder.png")
        }
        profileView.image = UIImage(data: contact.picture!)
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
        prepareCompanyLabel()
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
        layoutCompanyLabel()
    }
    
    /*
     @name   prepareDefaultImageView
     */
    public func prepareImageView()
 {
    profileView.image = UIImage(named: "photoplaceholder")
    profileView.layer.cornerRadius = profileView.frame.width/2
    profileView.contentMode = .ScaleAspectFill
    profileView.backgroundColor = Color.greyDark
    profileView.clipsToBounds = true
    addSubview(profileView)
    }
    
    
    /*
     @name   prepareDefaultLabel
     */
    public func prepareNameLabel() {
        nameLabel.font = Fonts.title
        nameLabel.textColor = Color.greyDark
        nameLabel.textAlignment = .Left
        addSubview(nameLabel)
    }
    
    public func prepareCompanyLabel() {
        companyLabel.font = Fonts.smallfont
        companyLabel.textColor = Color.greyMedium
        companyLabel.textAlignment = .Left
        addSubview(companyLabel)
    }

    
    /*
     @name   prepareDefaultDescription
     */
    public func prepareTitleLabel() {
        titleLabel.font = Fonts.smallfont
        titleLabel.textColor = Color.greyMedium
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
    
    public func layoutCompanyLabel() {
        let x = CGFloat(100.0)
        let y = CGFloat(30.0)
        let w = contentView.frame.width - (110.0)
        let h = CGFloat(20.0)
        companyLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    
    public func layoutTitleLabel() {
        let x = CGFloat(100.0)
        let y = CGFloat(50.0)
        let w = contentView.frame.width - (110.0)
        let h = CGFloat(20.0)
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
}



