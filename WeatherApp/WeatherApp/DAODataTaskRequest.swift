//
//  DAODataTaskRequest.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import Foundation

protocol DAODataTaskRequest : DAORequest
{
    
}

extension DAODataTaskRequest
{
    func send()
    {
        let url : NSURL = NSURL(string: urlString)!
        let session : NSURLSession = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = httpMethod
        let task = session.dataTaskWithRequest(request)
            {
                (let data : NSData?, let response : NSURLResponse?, let error: NSError?) -> Void in
                if (error != nil)
                {
                    self.didReceiveError(error!)
                }
                else
                {
                    self.didReceiveData(data!)
                }
        }
        task.resume()
    }
}