

import UIKit
import Material
import OAuthSwift

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
        
        cardView.frame = CGRectMake(0, 44, view.bounds.width, 450.0)
    }
    
    
    /// Prepares the searchBar
    
    private func prepareSearchBar() {
        searchBar = SearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        searchBar.textField.font = Fonts.bodyGrey
        view.addSubview(searchBar)
        
        
        // Setup the Search Button
        
        let searchImage: UIImage? = MaterialIcon.cm.search
        let searchButton: IconButton = IconButton()
        searchButton.pulseColor = MaterialColor.grey.base
        searchButton.tintColor = Color.accentColor1
        searchButton.setImage(searchImage, forState: .Normal)
        searchButton.setImage(searchImage, forState: .Highlighted)
        
        /*
         To lighten the status bar - add the
         "View controller-based status bar appearance = NO"
         to your info.plist file and set the following property.
         */
        searchBar.leftControls = [searchButton]
    }
}
