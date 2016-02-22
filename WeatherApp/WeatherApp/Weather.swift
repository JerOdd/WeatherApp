//
//  Weather.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

enum WeatherType
{
    case Sunny
    case Cloudy
}

class Weather: NSObject
{
    var id : Int
    var type : WeatherType
    
    init(withId id: Int, andType type: WeatherType)
    {
        self.id = id
        self.type = type
    }
}
