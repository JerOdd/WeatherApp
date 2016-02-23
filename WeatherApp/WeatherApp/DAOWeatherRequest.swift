//
//  DAOWeatherRequest.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import Foundation

protocol DAOWeatherRequestDelegate: class
{
    func didReceiveWeather(weather: Weather, forCity city: City)
}

class DAOWeatherRequest: DAODataTaskRequest
{
    weak var delegate: DAOWeatherRequestDelegate?
    var httpMethod : String = "GET"
    var urlString : String = "http://api.openweathermap.org/data/2.5/weather?id=2172797&APPID=b83c13b2ab60f7ec52b12d6fcf3f9f42"
    
    func didReceiveData(data: NSData)
    {
        do
        {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            print(json)
            let city : City = City(withDictionary: json as! Dictionary<String, AnyObject>)
            delegate?.didReceiveWeather(city.weather, forCity: city)
        }
        catch (let exception)
        {
            print(exception)
        }
    }
    
    func didReceiveError(error: NSError)
    {
        
    }
}
