

import UIKit
import Material

public class ContactsViewController: UIViewController {
    
    let cardView: MaterialPulseView = MaterialPulseView(frame: CGRect.zero)
    
    public lazy var tableView: UITableView = UITableView()
    
    private var containerView: UIView!
    
    var selectedIndexPath: NSIndexPath? = nil
    
    
    /// Reference for SearchBar.
    private var searchBar: SearchBar!
    
    
    //  viewDidLoad
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareTableView()
        prepareSearchBar()
        
    }
    
    //  viewDidLayoutSubviews
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
        
        cardView.frame = CGRectMake(0, 100, view.bounds.width, 450.0)
    }
    
    
    /// Prepares the searchBar
    
    private func prepareSearchBar() {
        searchBar = SearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        searchBar.textField.font = UIFont(name: "Avenir", size: CGFloat(15.0))
        view.addSubview(searchBar)
        
        // More button.
        
        let image: UIImage? = MaterialIcon.cm.search
        let moreButton: IconButton = IconButton()
        moreButton.pulseColor = MaterialColor.grey.base
        moreButton.tintColor = Color.accentColor1
        moreButton.setImage(image, forState: .Normal)
        moreButton.setImage(image, forState: .Highlighted)
        
        /*
         To lighten the status bar - add the
         "View controller-based status bar appearance = NO"
         to your info.plist file and set the following property.
         */
        searchBar.leftControls = [moreButton]
    }
}
