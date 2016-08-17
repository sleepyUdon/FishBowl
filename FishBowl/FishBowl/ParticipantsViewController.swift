import UIKit
import Material

public class ParticipantsViewController: UIViewController {
    
    public lazy var tableView: UITableView = UITableView()
    public var membersData: ParticipantsModel = ParticipantsModel()
    
//    private var containerView: UIView!
    
    /// Reference for SearchBar.
    private var searchBar: SearchBar!

    
    /*
     @name   viewDidLoad
     */
    public override func viewDidLoad() {
        super.viewDidLoad()
        //create an activity indicator
        let activityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIndicatorView.center = tableView.center
        //transform the indicator
        var transform = CGAffineTransform()
        transform = CGAffineTransformMakeScale(1.5, 1.5)
        activityIndicatorView.transform = transform
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
        //add ParticipantVC as an observer
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
    searchBar = SearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
    view.addSubview(searchBar)
    let image: UIImage? = MaterialIcon.cm.search
    searchBar.textField.font = Fonts.bodyGrey

    // More button.
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