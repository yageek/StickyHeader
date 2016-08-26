//
//  ViewControllerTwo.swift
//  StickyHeader
//
//  Created by Yannick Heinrich on 26.08.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import UIKit

class ViewControllerTwo: UITableViewController {
    let headerView: UIView = {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        view.backgroundColor = UIColor.blueColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.stickyHeader.view = self.headerView
        self.tableView.stickyHeader.height = 200
        self.tableView.stickyHeader.minimumHeight = 100
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        return cell
    }


}
