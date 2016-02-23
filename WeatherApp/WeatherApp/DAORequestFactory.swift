//
//  DAORequestFactory.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import Foundation

enum DAORequestType
{
    case DataTask
    case DownloadTask
}

class DAORequestFactory
{
    class func getDataTaskInstanceFromType(type : DAODataTaskType) -> DAORequest
    {
        return DAOWeatherRequest()
    }
    
    private class func getRequestInstanceFromType(type : DAORequestType) -> DAORequest
    {
        switch type
        {
            default:
                return DAOWeatherRequest()
        }
    }
}