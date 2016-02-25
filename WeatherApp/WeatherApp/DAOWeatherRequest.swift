//
//  DAOWeatherRequest.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import Foundation

protocol DAOWeatherRequestDelegate: class
{
    /**
     * Succeeded to retrieve information for the city
     * - Parameter city: the information for the city
     */
    func didReceiveWeatherInformationForCity(city: City)
    
    /**
     * Failed to retrieve information for the city
     * - Parameter city: The city sent in the request
     */
    func didFailToReceiveWeatherInformationForCity(city: City)
}

class DAOWeatherRequest
{
    weak var delegate: DAOWeatherRequestDelegate?
    
    /**
     * Download the weather information for a city
     * - Parameter city: The city
     */
    func downloadWeatherInformationForCity(city: City)
    {
        let url : NSURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?id=\(city.id!)&APPID=18ec4a3d8f396825d6f19c4b52d186c5")! // URL of the request
        let session : NSURLSession = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request)
            {
                (let data : NSData?, let response : NSURLResponse?, let error: NSError?) -> Void in
                if (error != nil)
                {
                    print(error)
                    
                    // We need to perform this code on the main thread
                    dispatch_async(dispatch_get_main_queue(),
                    {
                        self.delegate?.didFailToReceiveWeatherInformationForCity(city) // Haven't received any information
                    })
                }
                else
                {
                    do
                    {
                        // Parse the json into dictionary
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                        
                        // Init a city with the dictionary
                        let city : City = City(withDictionary: json as! Dictionary<String, AnyObject>)
                        
                        // We need to perform this code on the main thread
                        dispatch_async(dispatch_get_main_queue(),
                        {
                            // Notify the delegate with the city
                            self.delegate?.didReceiveWeatherInformationForCity(city)
                        })
                    }
                    catch (let exception as NSError)
                    {
                        print(exception)
                        
                        // We need to perform this code on the main thread
                        dispatch_async(dispatch_get_main_queue(),
                        {
                            self.delegate?.didFailToReceiveWeatherInformationForCity(city) // Haven't received any information
                        })
                    }
                }
        }
        task.resume()
    }
}
