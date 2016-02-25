//
//  City.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import Foundation

let idKey : String = "id" // The id key in json provided by the API
let nameKey : String = "name" // The name key in json provided by the API

class City: NSObject
{
    var name : NSString? // name of the city
    var id : Int? // id of the city
    var weather : Weather? // weather of the city
    
    override init()
    {
        
    }
    
    /**
     * Init a City object with a dictionary
     */
    init(withDictionary dictionary : Dictionary<String, AnyObject>)
    {
        self.name = dictionary[nameKey] as? NSString
        self.id = dictionary[idKey] as? Int
        self.weather = Weather(withDictionary: dictionary)
    }
}
