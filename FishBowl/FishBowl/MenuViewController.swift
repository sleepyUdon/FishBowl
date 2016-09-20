//  MenuViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.
import UIKit

public class MenuViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
    var eventsData: MenuModel = MenuModel()
    
    /*
     @name   viewDidLoad
     */
    override public func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didUpdateEvents), name: MenuModel.setEventsName, object: self.eventsData)
        eventsData.getEvents()
        prepareView()
        prepareTableView()
    }
    
    /*
     @name   viewDidLayoutSubviews
     */
    override public func viewDidLayoutSubviews() {
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
        view.backgroundColor = UIColor.redColor()
    }
    
    /*
     @name   prepareTableView
     */
    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.registerClass(EventsTableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let event = eventsData.events[indexPath.row]
        appDelegate.dataManager?.eventId = event.eventId
        print(event.eventId)
        let destination = ParticipantsViewController()
        
        navigationController?.pushViewController(destination, animated: false)
        destination.navigationItem.title = "Participants"
        destination.navigationItem.titleLabel.textAlignment = .Center
        destination.navigationItem.titleLabel.textColor = Color.accentColor1
        destination.navigationItem.titleLabel.font = Fonts.navigationTitle
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
}

