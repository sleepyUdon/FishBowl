//  MenuViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.
import UIKit

open class MenuViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
    var eventsData: MenuModel = MenuModel()
    
    /*
     @name   viewDidLoad
     */
    override open func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateEvents), name: NSNotification.Name(rawValue: MenuModel.setEventsName), object: self.eventsData)
        eventsData.getEvents()
        prepareView()
        prepareTableView()
    }
    
    /*
     @name   viewDidLayoutSubviews
     */
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
    }
    
    func didUpdateEvents() {
        self.tableView.reloadData()
    }
}

public extension MenuViewController {
    /*
     @name   prepareView
     */
    func prepareView() {
        view.backgroundColor = UIColor.red
    }
    
    /*
     @name   prepareTableView
     */
    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    /*
     @name   layoutTableView
     */
    public func layoutTableView() {
        tableView.frame = view.bounds
    }
}

extension MenuViewController: UITableViewDelegate {
    /*
     @name   required didSelectRowAtIndexPath
     */
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let event = eventsData.events[(indexPath as NSIndexPath).row]
        appDelegate.dataManager?.eventId = event.eventId
        print(event.eventId)
        let destination = ParticipantsViewController()
        
        navigationController?.pushViewController(destination, animated: false)
        destination.navigationItem.title = "Participants"
        destination.navigationItem.titleLabel.textAlignment = .center
        destination.navigationItem.titleLabel.textColor = Color.accentColor1
        destination.navigationItem.titleLabel.font = Fonts.navigationTitle
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

