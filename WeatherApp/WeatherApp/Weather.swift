//
//  Weather.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import Foundation

let mainKey : String = "main"
let temperatureMainKey : String = "temp"

let weatherKey : String = "weather"
let idWeatherKey : String = "id"
let mainWeatherKey : String = "main"
let descriptionWeatherKey : String = "description"
let iconWeatherKey : String = "icon"

class Weather: NSObject
{
    var id : Int = 0
    var temp : Float = 0.0
    var desc : String = ""
    var iconName : String = ""
    var main : String = ""
    
    override init()
    {
        
    }
    
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
