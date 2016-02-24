//
//  BOWeatherManager.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

protocol BOWeatherManagerDelegate: class
{
    func didReceiveWeather(weather: Weather, forCity city: City)
    func didReceiveWeatherImageData(data: NSData)
}

class BOWeatherManager: NSObject, DAOWeatherRequestDelegate, DAOWeatherImageRequestDelegate
{
    static let sharedManager = BOWeatherManager()
    
    weak var delegate : BOWeatherManagerDelegate?
    var cities : Array<City> = Array<City>()
    var weathers : Array<Weather> = Array<Weather>()
    
    func reloadCitiesAndWeathers()
    {
        cities.removeAll()
        weathers.removeAll()
        let request : DAOWeatherRequest = DAOWeatherRequest()
        request.delegate = self
        request.send()
    }
    
    func didReceiveWeather(weather: Weather, forCity city: City)
    {
        let request : DAOWeatherImageRequest = DAOWeatherImageRequest()
        request.delegate = self
        request.downloadContentWithParam(weather.iconName)
        cities.append(city)
        weathers.append(weather)
        delegate?.didReceiveWeather(weather, forCity: city)
    }
    
    func didReceiveWeatherImageData(data: NSData)
    {
        delegate?.didReceiveWeatherImageData(data)
    }
}
