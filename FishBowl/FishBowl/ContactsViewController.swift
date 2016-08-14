

import UIKit
import Material
import OAuthSwift

public class ContactsViewController: UIViewController,UISearchBarDelegate {
    
    let cardView: MaterialPulseView = MaterialPulseView(frame: CGRect.zero)
    public lazy var tableView: UITableView = UITableView()
    private var containerView: UIView!
    var selectedIndexPath: NSIndexPath? = nil
    var searchActive : Bool = false
    var filtered:[String] = []

    
    
    /// Reference for SearchBar.
    private var searchBar: UISearchBar!
    
    
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
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 44))
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    public func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    public func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let users = ContactsModel().getUsers()
        
        var userNameArray = [String]()
        
        for user in users {userNameArray.append(user.name)}

        filtered = userNameArray.filter({ (text) -> Bool in  
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData() 
    }

    
}

