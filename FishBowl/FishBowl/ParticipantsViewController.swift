//  ParticipantsViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import UIKit
import Material

public class ParticipantsViewController: UIViewController {
    
    lazy var tableView: UITableView = UITableView()
    var activityIndicator: UIActivityIndicatorView!
    var currentData:[Member] = []
    var filteredParticipants:[Member] = []
    var participantsModel: ParticipantsModel = ParticipantsModel()
    // Reference for SearchBar.
    private var searchBar: UISearchBar!
    
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

    /*
     @name   viewDidLoad
     */
    public override func viewDidLoad() {
        super.viewDidLoad()
        //add ParticipantVC as an observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didUpdateMembers), name: ParticipantsModel.setParticipants, object: nil)
        prepareView()
        prepareTableView()
        createActivityIndicator()
        updateMembers()
        prepareSearchBar()
        searchBar.tintColor = MaterialColor.pink.accent2
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
        currentData = participantsModel.members
        self.tableView.reloadData()
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
        searchBar.backgroundColor = UIColor.whiteColor()
        searchBar.searchBarStyle = UISearchBarStyle.Minimal
        
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
        cell.member = currentData[indexPath.row]

        return cell
    }
    
}

extension ParticipantsViewController: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}
