import UIKit
import Material

public class ParticipantsViewController: UIViewController {
    
    lazy var tableView: UITableView = UITableView()
    
    var currentData:[Member] = []
    var filteredParticipants:[Member] = []
    var participantsModel: ParticipantsModel = ParticipantsModel()
    
    var participantsSearchActive : Bool! {
        didSet {
            updateModel()
        }
    }
    
    private func updateModel() {
        if participantsSearchActive == true && filteredParticipants.count > 0 {
            currentData = filteredParticipants
        } else {
            currentData = participantsModel.members
        }
        self.tableView.reloadData()
    }
    
    
    var activityIndicator: UIActivityIndicatorView!
    
    
    /// Reference for SearchBar.
    private var searchBar: UISearchBar!
    
    
    /*
     @name   viewDidLoad
     */
    public override func viewDidLoad() {
        super.viewDidLoad()
        //create an activity indicator
        //add ParticipantVC as an observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didUpdateMembers), name: ParticipantsModel.setParticipants, object: nil)
        createActivityIndicator()
        updateMembers()
        prepareView()
        prepareTableView()
        prepareSearchBar()
    }
    
    private func updateMembers() {
        activityIndicator.startAnimating()
        participantsModel.getMembers()
    }
    
    /*
     @name   viewDidLayoutSubviews
     */
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
    }
    
    func didUpdateMembers() {
        self.activityIndicator.stopAnimating()
        self.participantsSearchActive = false
    }
    
    deinit {
        // remove notifications
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension ParticipantsViewController: UISearchBarDelegate {
    /// Prepares the searchBar
    private func prepareSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        participantsSearchActive = true;
    }
    
    public func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        participantsSearchActive = false
    }
    
    public func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        participantsSearchActive = false;
        tableView.reloadData()
    }
    
    public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        participantsSearchActive = false;
    }
    
    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let members = participantsModel.members

        let results = members.filter {
            let member = $0
            return member.memberName.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        }
        
        filteredParticipants = results
        
        updateModel()
    }
}

extension ParticipantsViewController {
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIndicator.center = tableView.center
        //transform the indicator
        var transform = CGAffineTransform()
        transform = CGAffineTransformMakeScale(1.5, 1.5)
        activityIndicator.transform = transform
        tableView.backgroundView = activityIndicator
        activityIndicator.hidesWhenStopped = true
    }
}

public extension ParticipantsViewController {
    /*
     @name   prepareView
     */
    public func prepareView() {
        view.backgroundColor = UIColor.redColor()
    }
    
    /*
     @name   prepareTableView
     */
    public func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(ParticipantsTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    
    /*
     @name   layoutTableView
     */
    public func layoutTableView() {
        
        view.layout(tableView).edges(top: 44, left: 0, right: 0)
    }
}

extension ParticipantsViewController: UITableViewDataSource {
    
    //    public lazy var menumodel:MenuModel = MenuModel()
    /*
     @name   numberOfSectionsInTableView
     */
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ParticipantsModel.sectionsCount()
    }
    
    /*
     @name   numberOfRowsInSection
     */
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return currentData.count
    }
    
    /*
     @name   cellForRowAtIndexPath
     */
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ParticipantsTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! ParticipantsTableViewCell
        cell.selectionStyle = .None
        
        //        cell.member = participantsSearchActive == true ? filteredParticipants[indexPath.row] : participantsModel.members[indexPath.row] as Member
        cell.member = currentData[indexPath.row]

        return cell
    }
    
}

extension ParticipantsViewController: UITableViewDelegate {
    
    /*
     @name   required didSelectRowAtIndexPath
     */
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        let cell = tableView.cellForRowAtIndexPath(indexPath)
        //        return cell.height() VIVFIX THIS
        return 60
    }
    
}
