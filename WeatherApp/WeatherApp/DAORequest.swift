//
//  DAORequest.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import Foundation

protocol DAORequest
{
    var urlString : String {get set}
    var httpMethod : String {get set}
    
    func didReceiveData(data : NSData)
    func didReceiveError(error : NSError)
}

extension DAORequest
{

}