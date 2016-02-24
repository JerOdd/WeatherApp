//
//  UICitiesTableViewController.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

class UICitiesTableViewController: UITableViewController, BOWeatherManagerDelegate
{
    var weathersImages : Array<UIImage> = Array<UIImage>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
        
        if numberOfRows == 0
        {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No Data. Please Pull to Refresh"
            noDataLabel.textColor = UIColor.blackColor()
            noDataLabel.textAlignment = NSTextAlignment.Center
            noDataLabel.sizeToFit()
            
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        else
        {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            tableView.backgroundView = nil
        }
        
        return numberOfRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : UICitiesTableViewCell = tableView.dequeueReusableCellWithIdentifier("cityCellIdentifier", forIndexPath: indexPath) as! UICitiesTableViewCell

        let city : City = BOWeatherManager.sharedManager.cities[indexPath.row]
        
        cell.cityNameLabel.text = city.name as? String
        cell.cityTemperatureLabel.text = "\(String(city.weather!.temp))°F"
        
        //TODO
        if indexPath.row <= weathersImages.count - 1
        {
            cell.weatherImageView.image = weathersImages[indexPath.row]
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let city : City = BOWeatherManager.sharedManager.cities[indexPath.row]
        appDelegate.citiesDescriptionViewController?.reloadDisplayWithCity(city, andWeatherImage: weathersImages[indexPath.row])
        splitViewController?.showDetailViewController(appDelegate.citiesDescriptionViewController!, sender: nil)
    }
    
    @IBAction func onValueChanged(sender: UIRefreshControl)
    {
        BOWeatherManager.sharedManager.reloadCitiesAndWeathers()
    }
    
    // MARK: - BOWeatherManagerDelegate
    
    func didReceiveWeather(weather: Weather, forCity city: City)
    {
        tableView.reloadData()
    }
    
    func didReceiveWeatherImageData(data: NSData)
    {
        let weatherImage : UIImage = UIImage(data: data)!
        weathersImages.append(weatherImage)
        tableView.reloadData()
        
        if (self.refreshControl != nil)
        {
            self.refreshControl?.endRefreshing()
        }
    }
}
