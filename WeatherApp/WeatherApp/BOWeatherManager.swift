//
//  BOWeatherManager.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import Foundation

protocol BOWeatherManagerDelegate: class
{
    /**
     * Received all the information we needed
     */
    func didReceiveAllWeatherInformation()
}

class BOWeatherManager: NSObject, DAOWeatherRequestDelegate, DAOWeatherImageRequestDelegate
{
    static let sharedManager = BOWeatherManager() // This class is a singleton
    
    weak var delegate : BOWeatherManagerDelegate?
    var cities : Dictionary<City, NSData> = Dictionary<City, NSData>() // Dictionary of all cities with their image data
    var downloadingRequestCount : Int = 0 // number of download in process
    
    /**
     * Reload all the cities information
     */
    func reloadCitiesAndWeathers()
    {
        // Remove all the cities we had in the list
        cities.removeAll()
        
        // Init the request
        let request : DAOWeatherRequest = DAOWeatherRequest()
        request.delegate = self
        
        for city in createCities()
        {
            // Send the request to retrieve information
            request.downloadWeatherInformationForCity(city)
            
            // Increment the number of download in process
            downloadingRequestCount++
        }
    }
    
    /**
     * Init all the cities we want
     */
    private func createCities() -> Array<City>
    {
        var testCities = Array<City>()
        
        // Paris
        let paris = City()
        paris.id = 6455259
        testCities.append(paris)
        
        // London
        let london = City()
        london.id = 2643743
        testCities.append(london)
        
        // New-York
        let newYork = City()
        newYork.id = 5128638
        testCities.append(newYork)
        
        // Berlin
        let berlin = City()
        berlin.id = 2950159
        testCities.append(berlin)
        
        return testCities
    }
    
    /**
     * Succeeded to retrieve information for the city
     * - Parameter city: the information for the city
     */
    func didReceiveWeatherInformationForCity(city: City)
    {
        let request : DAOWeatherImageRequest = DAOWeatherImageRequest()
        request.delegate = self
        
        // Start the download of the image linked to the weather
        request.downloadWeatherImageForCity(city)
    }
    
    /**
     * Failed to retrieve information for the city
     * - Parameter city: The city sent in the request
     */
    func didFailToReceiveWeatherInformationForCity(city: City)
    {
        // It failed... But still have received a response...
        responseHasBeenReceived()
    }
    
    /**
     * Succeeded to retrieve image for the weather of the city
     * - Parameter city: the city given in the request
     * - Parameter data: The retrieved image data
     */
    func didReceiveWeatherImageInformationForCity(city : City, withImageData data: NSData)
    {
        // Adding the city and the data into the dictionary
        cities[city] = data
        
        // Have received a response for a request
        responseHasBeenReceived()
    }
    
    /**
     * Failed to retrieve image for the weather of the city
     * - Parameter city: the city given in the request
     */
    func didFailToReceiveWeatherImageInformationForCity(city: City)
    {
        // It failed... But still have received a response...
        responseHasBeenReceived()
    }
    
    /**
     * Response has been received for a request
     */
    private func responseHasBeenReceived()
    {
        // Decrease the count of downloading request
        downloadingRequestCount--
        
        if downloadingRequestCount == 0 // All response has been received
        {
            // Notify the display that he can reload all its components
            delegate?.didReceiveAllWeatherInformation()
        }
    }
}
