//
//  BOCityManager.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

class BOCityManager: NSObject
{
    static let sharedManager : BOCityManager = BOCityManager()
    
    var favorites : Array<City>?
    
    func saveCity(city : City)
    {
        if shouldSaveCity(city)
        {
            DAOCitiesStorage.saveCity(city)
            favorites?.append(city)
        }
    }
    
    private func shouldSaveCity(city : City) -> Bool
    {
        for savedCity in favorites!
        {
            if city.name == savedCity.name && city.id == savedCity.id
            {
                return false
            }
        }
        
        return true
    }
    
    func removeCity(city : City)
    {
        DAOCitiesStorage.removeCity(city)
        favorites?.removeLast()
    }
    
    func getAllSavedCities()
    {
        favorites = DAOCitiesStorage.getAllSavedCities()
    }
}
