//
//  MenuViewController.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-06-25.
//  Copyright (c) 2015 Adam Dahan. All rights reserved.
//

import UIKit

public class ParticipantsViewController: UIViewController {
    
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
