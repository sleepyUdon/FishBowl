import UIKit
import Material

public class ParticipantsViewController: UIViewController, UISearchBarDelegate {
    
    public lazy var tableView: UITableView = UITableView()
    public var membersData: ParticipantsModel = ParticipantsModel()
    var participantsSearchActive : Bool = false
    var filteredParticipants:[String] = []

    /// Reference for SearchBar.
    private var participantsSearchBar: UISearchBar!

    
    /*
     @name   viewDidLoad
     */
    public override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didUpdateMemebers), name: ParticipantsModel.setParticipants, object: self.membersData)
        membersData.getMembers()
        prepareView()
        prepareTableView()
        prepareSearchBar()
    }
    
    /*
     @name   viewDidLayoutSubviews
     */
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
    }
    
    func didUpdateMemebers() {
        self.tableView.reloadData()
    }


/// Prepares the searchBar
private func prepareSearchBar() {
    participantsSearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
    participantsSearchBar.delegate = self
    view.addSubview(participantsSearchBar)
}
    
    public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        participantsSearchBar.showsCancelButton = true
        participantsSearchActive = true;
    }
    
    public func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        participantsSearchBar.showsCancelButton = false
        participantsSearchBar.text = ""
        participantsSearchActive = false;
    }
    
    public func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        participantsSearchBar.endEditing(true)
        participantsSearchActive = false;
    }
    
    public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        participantsSearchBar.endEditing(true)
        participantsSearchActive = false;
    }
    
    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let members = membersData.members
        
        var participantsNameArray = [String]()
        
        for member in members {participantsNameArray.append(member.memberName)}
        
        filteredParticipants = participantsNameArray.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filteredParticipants.count == 0){
            participantsSearchActive = false;
        } else {
            participantsSearchActive = true;
        }
        self.tableView.reloadData()
    }
    

}