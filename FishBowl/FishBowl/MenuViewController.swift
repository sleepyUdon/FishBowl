

import UIKit

public class MenuViewController: UIViewController {
    
    public lazy var tableView: UITableView = UITableView()
    public var eventsData: MenuModel = MenuModel()
    
    /*
    @name   viewDidLoad
    */
    public override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didUpdateEvents), name: MenuModel.setEventsName, object: self.eventsData)
        eventsData.getEvents()
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
    
    func didUpdateEvents() {
        self.tableView.reloadData()
    }
}
