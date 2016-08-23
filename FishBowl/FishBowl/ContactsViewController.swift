

import UIKit
import Material
import OAuthSwift

public class ContactsViewController: UIViewController,UISearchBarDelegate {
    
    let cardView: MaterialPulseView = MaterialPulseView(frame: CGRect.zero)
    public lazy var tableView: UITableView = UITableView()
    private var containerView: UIView!
//    var selectedIndexPath: NSIndexPath? = nil
//    var searchActive : Bool = false
//    var filtered:[String] = []
//    var users: [User] = [User]()
//    public var userData: ContactsModel = ContactsModel()
    
    var currentData:[User] = []
    var filteredContacts:[User] = []
    var contactsModel: ContactsModel = ContactsModel()
    
    
    /// Reference for SearchBar.
//    private var searchBar: UISearchBar!
    var contactsSearchActive:Bool! {
        didSet {
            updateModel()
        }
    }
    
    private func updateModel() {
        if contactsSearchActive == true && filteredContacts.count > 0 {
            currentData = filteredContacts
        }
        else {
            currentData = contactsModel.contacts
        }
        self.tableView.reloadData()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.didUpdateContacs),
                                                         name: "NewParticipantAdded",
                                                         object: nil)
        prepareView() 
        prepareTableView()
        didUpdateContacs()
        prepareSearchBar()
        cardView.alpha = 0.0
    }
    
    
    func didUpdateContacs() {
        currentData = contactsModel.contacts
        self.contactsSearchActive = false
        self.tableView.reloadData()
    }
    
    deinit {
        // remove notifications
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //  viewDidLayoutSubviews
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
        cardView.frame = CGRectMake(0, 0, view.bounds.width, 450.0)
    }
    
    
    /// Prepares the searchBar
    
    private func prepareSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 44))
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchActive = true;
    }
    
    public func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchActive = false;
    }
    
    public func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchActive = false;
        tableView.reloadData()

    }
    
    public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
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

extension ContactsViewController: UITableViewDataSource {
    
    
    /*
     @name   numberOfSectionsInTableView
     */
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     @name   numberOfRowsInSection
     */
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            if filtered.count == 0{
                return users.count
            } else {
                return self.filtered.count
            }
        } else {
            return users.count
        }
    }
    
    
    /*
     @name   cellForRowAtIndexPath
     */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ContactsTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! ContactsTableViewCell
        if(searchActive){
            cell.nameLabel.text = filtered[indexPath.row]
            for user in users {
                if user.name == filtered[indexPath.row] {
                    cell.titleLabel.text = user.bio
                }
            }
            for user in users {
                if user.name == filtered[indexPath.row] {
                    cell.profileView.image = UIImage(data: user.image!)
                }
            }
            
        } else {
            let user = users[indexPath.row]
            cell.nameLabel.text = user.name
            cell.titleLabel.text = user.bio
            cell.profileView.image = UIImage(data: user.image!)
        }
        return cell
    }
    
}


