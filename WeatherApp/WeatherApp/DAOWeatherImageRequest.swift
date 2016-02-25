//
//  DAOWeatherImageRequest.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import Foundation

protocol DAOWeatherImageRequestDelegate: class
{
    /**
     * Succeeded to retrieve image for the weather of the city
     * - Parameter city: the city given in the request
     * - Parameter data: The retrieved image data
     */
    func didReceiveWeatherImageInformationForCity(city : City, withImageData data: NSData)
    
    /**
     * Failed to retrieve image for the weather of the city
     * - Parameter city: the city given in the request
     */
    func didFailToReceiveWeatherImageInformationForCity(city : City)
}

class DAOWeatherImageRequest
{
    weak var delegate : DAOWeatherImageRequestDelegate?
    
    /**
     * Download the weather image information for a city
     * - Parameter city: The city
     */
    func downloadWeatherImageForCity(city : City)
    {
        let url : NSURL = NSURL(string: "http://openweathermap.org/img/w/\(city.weather!.iconName).png")!
        let session : NSURLSession = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        let downloadTask = session.downloadTaskWithRequest(request)
            {
                (let location : NSURL?, let response : NSURLResponse?, let error: NSError?) -> Void in
                if (error != nil)
                {
                    print(error)
                    
                    dispatch_async(dispatch_get_main_queue(),
                    {
                        self.delegate?.didFailToReceiveWeatherImageInformationForCity(city) // Haven't received any information
                    })
                }
                else
                {
                    do
                    {
                        let data : NSData = try NSData(contentsOfURL: location!, options: NSDataReadingOptions.DataReadingMapped)
                        
                        // We need to perform this code on the main thread
                        dispatch_async(dispatch_get_main_queue(),
                        {
                            // Notify the delegate with the city and the data
                            self.delegate?.didReceiveWeatherImageInformationForCity(city, withImageData: data)
                        })
                    }
                    catch(let exception as NSError)
                    {
                        print(exception)
                        
                        dispatch_async(dispatch_get_main_queue(),
                        {
                            self.delegate?.didFailToReceiveWeatherImageInformationForCity(city) // Haven't received any information
                        })
                    }
                }
        }
        downloadTask.resume()
    }
}
