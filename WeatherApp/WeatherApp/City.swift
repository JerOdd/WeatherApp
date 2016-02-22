//
//  City.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

class City: NSObject
{
    var name : NSString
    var id : Int
    var weather : Weather
    
    init(withName name:String, Id id:Int, andWeather weather: Weather)
    {
        self.name = name
        self.id = id
        self.weather = weather
    }
}
