//
//  DAODataTaskFactory.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

enum DAODataTaskType
{
    case Weather
}

class DAODataTaskFactory: NSObject
{
    class func getDataTaskInstanceFromType(type : DAODataTaskType) -> DAODataTaskRequest
    {
        switch type
        {
            case DAODataTaskType.Weather:
                return DAOWeatherRequest()
        }
    }
}
