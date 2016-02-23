//
//  DAODownloadTaskRequest.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import Foundation

protocol DAODownloadTaskRequest : DAORequest
{
    
}

extension DAODownloadTaskRequest
{
    func downloadContentWithParam(param : String)
    {
        let url : NSURL = NSURL(string: "http://openweathermap.org/img/w/\(param).png")!
        let session : NSURLSession = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        let downloadTask = session.downloadTaskWithRequest(request)
            {
                (let location : NSURL?, let response : NSURLResponse?, let error: NSError?) -> Void in
                if (error != nil)
                {
                    //self.didReceiveError(error!)
                }
                else
                {
                    do
                    {
                        let data : NSData = try NSData(contentsOfURL: location!, options: NSDataReadingOptions.DataReadingMapped)
                        self.didReceiveData(data)
                    }
                    catch(let exception)
                    {
                        print(exception)
                    }
                }
        }
        downloadTask.resume()
    }
}