//
//  UICitiesDescriptionViewController.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import UIKit

class UICitiesDescriptionViewController: UIViewController
{
    @IBOutlet weak var weatherImageView: UIImageView! // shows the image of the weather
    @IBOutlet weak var addToFavoriteButton: UIButton! // add the city to the favorites
    @IBOutlet weak var weatherDescriptionLabel: UILabel! // gives the description of the weather
    @IBOutlet weak var selectACityLabel: UILabel! // is displayed when no city is selected
    
    var selectedCity : City? // the selected city
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // No city is selected at this moment, we give the "Select a City" advice at the screen
        displaySelectACityLabel()
    }
    
    // MARK: - Event on the add to favorites button
    
    @IBAction func onAddToFavoritesTouched(sender: UIButton)
    {
        // Save the city to the favorites
        BOCityManager.sharedManager.saveCity(selectedCity!)
    }
    
    // MARK: - Reload of all components
    
    /**
     * Reload the screen with new city weather information
     * - Parameter city: The selected city
     * - Parameter weatherImage: The selected weather image city
     */
    func reloadDisplayWithCity(city : City, andWeatherImage weatherImage : UIImage)
    {
        selectedCity = city
        weatherDescriptionLabel.text = city.weather!.desc
        weatherImageView.image = weatherImage
        hideSelectACityLabel()
    }
    
    // MARK: - Handle the components display
    
    /**
     * Display a message when no cities are selected
     */
    private func displaySelectACityLabel()
    {
        selectACityLabel.hidden = false
        weatherImageView.hidden = true
        addToFavoriteButton.hidden = true
        weatherDescriptionLabel.hidden = true
    }
    
    /**
     * Hide the message when no cities are selected
     */
    private func hideSelectACityLabel()
    {
        selectACityLabel.hidden = true
        weatherImageView.hidden = false
        addToFavoriteButton.hidden = false
        weatherDescriptionLabel.hidden = false
    }
}
