import UIKit
import Material

public class ParticipantsViewController: UIViewController {
    
    public lazy var tableView: UITableView = UITableView()
    
//    private var containerView: UIView!
    
    /// Reference for SearchBar.
    private var searchBar: SearchBar!

    
    /*
     @name   viewDidLoad
     */
    public override func viewDidLoad() {
        super.viewDidLoad()
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


/// Prepares the searchBar
private func prepareSearchBar() {
    searchBar = SearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
    view.addSubview(searchBar)
    let image: UIImage? = MaterialIcon.cm.search
    searchBar.textField.font = UIFont(name: "Avenir", size: CGFloat(15.0))

    // More button.
    let moreButton: IconButton = IconButton()
    moreButton.pulseColor = MaterialColor.grey.base
    moreButton.tintColor = UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100)
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