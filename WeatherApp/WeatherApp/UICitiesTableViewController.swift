//
//  UICitiesTableViewController.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

class UICitiesTableViewController: UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCellIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
}
