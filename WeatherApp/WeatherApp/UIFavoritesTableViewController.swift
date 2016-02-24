//
//  UIFavoritesTableViewController.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

class UIFavoritesTableViewController: UITableViewController
{
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let numberOfRows = BOCityManager.sharedManager.favorites!.count
        
        if numberOfRows == 0 // Display a "No favorites yet" message
        {
            showNoFavoriteMessage()
        }
        else // Hide the message
        {
            hideNoFavoriteMessage()
        }
        
        return numberOfRows
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("favoriteCell", forIndexPath: indexPath)

        cell.textLabel?.text = BOCityManager.sharedManager.favorites![indexPath.row].name as? String

        return cell
    }
    
    // MARK: - Table view delegate

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            // Delete the city from the favorites list
            BOCityManager.sharedManager.removeCity(BOCityManager.sharedManager.favorites![indexPath.row])
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    // MARK: - No favorites message
    
    /**
     * Display A no favorite message when the list of favorites is empty
     */
    private func showNoFavoriteMessage()
    {
        // Creation of the label
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text = "No favorites yet."
        noDataLabel.textColor = UIColor.blackColor()
        noDataLabel.textAlignment = NSTextAlignment.Center
        noDataLabel.sizeToFit()
        
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    /**
     * Hide the no favorite message
     */
    private func hideNoFavoriteMessage()
    {
        tableView.backgroundView = nil
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    }
}
