//
//  DAORequest.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import Foundation

protocol DAORequest
{
    func didReceiveData(data : NSData)
}

extension DAORequest
{
    func send()
    {
        let url : NSURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?id=2172797")!
        let session : NSURLSession = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request)
        {
            (let data : NSData?, let response : NSURLResponse?, let error: NSError?) -> Void in
                if (data != nil)
                {
                    let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(dataString)
                }
            
                if (response != nil)
                {
                    print(response?.description)
                }
            
                if (error != nil)
                {
                    print(error?.description)
                }
        }
        task.resume()
    }
}

class DAOWeatherRequest: DAORequest
{
    func didReceiveData(data: NSData)
    {
        
    }
}
