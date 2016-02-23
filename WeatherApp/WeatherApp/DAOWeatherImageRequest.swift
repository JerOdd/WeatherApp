//
//  DAOWeatherImageRequest.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import Foundation

protocol DAOWeatherImageRequestDelegate: class
{
    func didReceiveWeatherImageData(data: NSData)
}

class DAOWeatherImageRequest: DAODownloadTaskRequest
{
    weak var delegate : DAOWeatherImageRequestDelegate?
    
    var urlString : String = "GET"
    var httpMethod : String = "http://openweathermap.org/img/w/"
    
    func didReceiveData(data: NSData)
    {
        self.delegate!.didReceiveWeatherImageData(data)
    }
    
    func didReceiveError(error: NSError)
    {
        
    }
}
