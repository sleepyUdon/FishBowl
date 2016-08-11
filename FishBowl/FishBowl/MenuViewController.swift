

import UIKit

public class MenuViewController: UIViewController {
    
    public lazy var tableView: UITableView = UITableView()
    
    /*
    @name   viewDidLoad
    */
    public override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareTableView()
    }
    
    /*
    @name   viewDidLayoutSubviews
    */
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
    }
}
