//
//  UICitiesTableViewController.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import UIKit

class UICitiesTableViewController: UITableViewController, BOWeatherManagerDelegate
{
    var citiesDescriptionViewController : UICitiesDescriptionViewController? // The description controller
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        citiesDescriptionViewController = appDelegate.citiesDescriptionViewController

        BOWeatherManager.sharedManager.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let numberOfRows = BOWeatherManager.sharedManager.cities.count
        
        if numberOfRows == 0 // There is no row, we display the no data label
        {
            displayNoDataLabel()
        }
        else // Hide no data label and display the rows
        {
            hideNoDataLabel()
        }
        
        return numberOfRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : UICitiesTableViewCell = tableView.dequeueReusableCellWithIdentifier("cityCellIdentifier", forIndexPath: indexPath) as! UICitiesTableViewCell

        // Retrieve the city for the row
        let city : City = Array<City>(BOWeatherManager.sharedManager.cities.keys)[indexPath.row]
        
        // Set UI Components
        cell.cityNameLabel.text = city.name as? String
        cell.cityTemperatureLabel.text = "\(String(city.weather!.temp))°F"
        cell.weatherImageView.image = UIImage(data: BOWeatherManager.sharedManager.cities[city]!)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        // Retrieve the city and the weather image
        let city : City = Array<City>(BOWeatherManager.sharedManager.cities.keys)[indexPath.row]
        let weatherImage = UIImage(data: BOWeatherManager.sharedManager.cities[city]!)
        
        // Reload and show the description controller
        citiesDescriptionViewController?.reloadDisplayWithCity(city, andWeatherImage: weatherImage!)
        splitViewController?.showDetailViewController(citiesDescriptionViewController!, sender: nil)
    }
    
    // MARK: - No data label
    
    /**
     * Display no data label
     */
    private func displayNoDataLabel()
    {
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text = "No Data. Please Pull to Refresh"
        noDataLabel.textColor = UIColor.blackColor()
        noDataLabel.textAlignment = NSTextAlignment.Center
        noDataLabel.sizeToFit()
        
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    /**
     * Hide no data label
     */
    private func hideNoDataLabel()
    {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.backgroundView = nil
    }
    
    // MARK: - Pull to refresh
    
    @IBAction func onValueChanged(sender: UIRefreshControl)
    {
        BOWeatherManager.sharedManager.reloadCitiesAndWeathers()
    }
    
    /**
     * End refreshing the refresh control
     */
    private func endRefreshing()
    {
        if (self.refreshControl != nil)
        {
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - BOWeatherManagerDelegate
    
    func didReceiveAllWeatherInformation()
    {
        tableView.reloadData()
        endRefreshing()
    }
}
