//
//  City.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import Foundation

let idKey : String = "id"
let nameKey : String = "name"

class City: NSObject
{
    var name : NSString
    var id : Int
    var weather : Weather
    
    init(withDictionary dictionary : Dictionary<String, AnyObject>)
    {
        self.name = dictionary[nameKey] as! NSString
        self.id = dictionary[idKey] as! Int
        self.weather = Weather(withDictionary: dictionary)
    }
}
