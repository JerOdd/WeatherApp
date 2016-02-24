//
//  UICitiesDescriptionViewController.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

class UICitiesDescriptionViewController: UIViewController
{
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var addToFavoriteButton: UIButton!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var selectACityLabel: UILabel!
    
    var selectedCity : City?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        selectACityLabel.hidden = false
        weatherImageView.hidden = true
        addToFavoriteButton.hidden = true
        weatherDescriptionLabel.hidden = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadDisplayWithCity(city : City, andWeatherImage weatherImage : UIImage)
    {
        selectedCity = city
        weatherDescriptionLabel.text = city.weather!.desc
        weatherImageView.image = weatherImage
        selectACityLabel.hidden = true
        weatherImageView.hidden = false
        addToFavoriteButton.hidden = false
        weatherDescriptionLabel.hidden = false
    }
    
    @IBAction func onAddToFavoritesTouched(sender: UIButton)
    {
        BOCityManager.sharedManager.saveCity(selectedCity!)
        (UIApplication.sharedApplication().delegate as! AppDelegate).favoritesTableViewController?.tableView.reloadData()
        (UIApplication.sharedApplication().delegate as! AppDelegate).favoritesTableViewController?.tabBarItem.badgeValue = "\(BOCityManager.sharedManager.favorites!.count)"
    }
    
}
