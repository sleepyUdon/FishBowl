

import UIKit
import Material
import OAuthSwift

public class ContactsViewController: UIViewController {
    
    public lazy var tableView: UITableView = UITableView()
    
    private var containerView: UIView!
    
    /// Reference for SearchBar.
    private var searchBar: SearchBar!

    
    //  viewDidLoad
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareContainerView()
        prepareSearchBar() //#SEARCHBAR VIV search bar not showing
        prepareTableView()
    }
    
    //  viewDidLayoutSubviews
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
    }
    
    /// Prepares the containerView.
    
    private func prepareContainerView() {
        containerView = UIView()
        view.layout(containerView).edges(top: 0, left: 0, right: 0)
    }
    
    /// Prepares the searchBar
    
    private func prepareSearchBar() {
        searchBar = SearchBar()
        searchBar.textField.font = UIFont(name: "Avenir", size: CGFloat(15.0))
        containerView.addSubview(searchBar)
        let image: UIImage? = MaterialIcon.cm.search

    // More button.
        
        let moreButton: IconButton = IconButton()
        moreButton.pulseColor = MaterialColor.grey.base
        moreButton.tintColor = Color.baseColor2
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
