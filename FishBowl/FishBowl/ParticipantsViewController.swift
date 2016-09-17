//  ParticipantsViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import UIKit
import Material

open class ParticipantsViewController: UIViewController {
    
    lazy var tableView: UITableView = UITableView()
    var activityIndicator: UIActivityIndicatorView!
    var currentData:[Member] = []
    var filteredParticipants:[Member] = []
    var participantsModel: ParticipantsModel = ParticipantsModel()
    // Reference for SearchBar.
    fileprivate var searchBar: UISearchBar!
    
    var participantsSearchActive : Bool! {
        didSet {
            updateModel()
        }
    }
    
    fileprivate func updateModel() {
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
    open override func viewDidLoad() {
        super.viewDidLoad()
        //add ParticipantVC as an observer
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateMembers), name: NSNotification.Name(rawValue: ParticipantsModel.setParticipants), object: nil)
        prepareView()
        prepareTableView()
        createActivityIndicator()
        updateMembers()
        prepareSearchBar()
    }
    
    fileprivate func updateMembers() {
        activityIndicator.startAnimating()
        participantsModel.getMembers()
    }
    
    /*
     @name   viewDidLayoutSubviews
     */
    open override func viewDidLayoutSubviews() {
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
        NotificationCenter.default.removeObserver(self)
    }
}

extension ParticipantsViewController: UISearchBarDelegate {
    /// Prepares the searchBar
    fileprivate func prepareSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        searchBar.delegate = self
        searchBar.barTintColor =  UIColor.white
        searchBar.backgroundColor = UIColor.white
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        
        view.addSubview(searchBar)
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        participantsSearchActive = true;
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        participantsSearchActive = false
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        participantsSearchActive = false;
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        participantsSearchActive = false;
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let members = participantsModel.members

        let results = members.filter {
            let member = $0
            return member.memberName.range(of: searchText, options: .caseInsensitive) != nil
        }
        
        filteredParticipants = results
        updateModel()
    }
}

extension ParticipantsViewController {
    fileprivate func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = tableView.center
        //transform the indicator
        var transform = CGAffineTransform()
        transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
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
        view.backgroundColor = UIColor.red
    }
    
    /*
     @name   prepareTableView
     */
    public func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ParticipantsTableViewCell.self, forCellReuseIdentifier: "Cell")
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
    public func numberOfSections(in tableView: UITableView) -> Int {
        return ParticipantsModel.sectionsCount()
    }
    
    /*
     @name   numberOfRowsInSection
     */
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    /*
     @name   cellForRowAtIndexPath
     */
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ParticipantsTableViewCell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! ParticipantsTableViewCell
        cell.selectionStyle = .none
        cell.member = currentData[(indexPath as NSIndexPath).row]

        return cell
    }
    
}

extension ParticipantsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
