//
//  Weather.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import Foundation

let mainKey : String = "main" // The main key in json provided by the API
let temperatureMainKey : String = "temp" // The temperature key in json provided by the API

let weatherKey : String = "weather" // The weather key in json provided by the API
let idWeatherKey : String = "id" // The id key in json provided by the API
let mainWeatherKey : String = "main" // The main key in json provided by the API
let descriptionWeatherKey : String = "description" // The description key in json provided by the API
let iconWeatherKey : String = "icon" // The icon key in json provided by the API

class Weather: NSObject
{
    var id : Int = 0 // id of the city
    var temp : Float = 0.0 // temperature of the city
    var desc : String = "" // small description of the weather
    var iconName : String = "" // icon name of the weather
    var main : String = "" // main weather
    
    override init()
    {
        
    }
    
    /**
     * Init a Weather object with a dictionary
     */
    init(withDictionary dictionary : Dictionary<String,AnyObject>)
    {
        let mainDictionary : Dictionary<String,AnyObject> = dictionary[mainKey] as! Dictionary<String,AnyObject>
        let weatherArray : Array<AnyObject> = dictionary[weatherKey] as! Array<AnyObject>
        let weatherDictionary = weatherArray[0]
        
        self.id = weatherDictionary[idWeatherKey] as! Int
        self.temp = mainDictionary[temperatureMainKey] as! Float
        self.desc = weatherDictionary[descriptionWeatherKey] as! String
        self.iconName = weatherDictionary[iconWeatherKey] as! String
        self.main = weatherDictionary[mainWeatherKey] as! String
    }
}
