//
//  BOCityManager.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import Foundation

protocol BOCityManagerDelegate: class
{
    /**
     * Called when a city has been saved to the favorites
     */
    func didSaveCity(city : City)
}

class BOCityManager: NSObject
{
    static let sharedManager : BOCityManager = BOCityManager() // This class must be a singleton
    
    weak var delegate : BOCityManagerDelegate?
    
    var favorites : Array<City>? // List of all favorites
    
    /**
     * Save the city in the favorites
     */
    func saveCity(city : City)
    {
        if shouldSaveCity(city) // check if we can add this city to the favorite
        {
            DAOCitiesStorage.saveCity(city) // Save in database
            favorites?.append(city) // Add it to the list
            delegate?.didSaveCity(city) // Notify the delegate that we've just save a city
        }
    }
    
    /**
     * Check if we can save the selected city, if it is not already in the list
     */
    private func shouldSaveCity(city : City) -> Bool
    {
        for savedCity in favorites!
        {
            if city.name == savedCity.name && city.id == savedCity.id
            {
                return false // it's already in the list, we don't want to save it
            }
        }
        
        return true
    }
    
    /**
     * Remove the city from the favorites
     */
    func removeCity(city : City)
    {
        DAOCitiesStorage.removeCity(city) // remove it from the database
        
        for var i = favorites!.count - 1; i >= 0; i--
        {
            if favorites![i].id == city.id && favorites![i].name == city.name
            {
                favorites?.removeAtIndex(i) // remove it from the list
            }
        }
    }
    
    /**
     * Fetch all saved favorites
     */
    func getAllSavedCities()
    {
        favorites = DAOCitiesStorage.getAllSavedCities() // Add all the favorites to an array
    }
}
