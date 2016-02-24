//
//  DAOCitiesStorage.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

import CoreData

class DAOCitiesStorage: NSObject
{
    class func saveCity(city: City)
    {
        let managedObjectContext = DAOStorage.sharedInstance.managedObjectContext
        
        let cityEntity = NSEntityDescription.entityForName("City", inManagedObjectContext: managedObjectContext)
        
        let cityObject = NSManagedObject(entity: cityEntity!, insertIntoManagedObjectContext: managedObjectContext)
        
        cityObject.setValue(city.name, forKey: "name")
        cityObject.setValue(city.id, forKey: "id")
        
        do
        {
            try managedObjectContext.save()
        }
        catch let error as NSError
        {
            "Couldn't save City \(error)"
        }
    }
    
    class func removeCity(city: City)
    {
        let managedObjectContext = DAOStorage.sharedInstance.managedObjectContext
        
        let cityManagedObject = getCityEntityFromCity(city)
        
        managedObjectContext.deleteObject(cityManagedObject!)
        
        do
        {
            try managedObjectContext.save()
        }
        catch let error as NSError
        {
            "Couldn't remove City \(error)"
        }
    }
    
    class func getAllSavedCities() -> Array<City>?
    {
        let managedObjectContext = DAOStorage.sharedInstance.managedObjectContext
        
        let fetchCitiesRequest = NSFetchRequest(entityName: "City")
        
        do
        {
            let cityEntities = try managedObjectContext.executeFetchRequest(fetchCitiesRequest) as! [NSManagedObject]
            
            var cities : Array<City> = Array<City>()
            
            for cityEntity in cityEntities
            {
                let city : City = City()
                city.id = cityEntity.valueForKey("id") as? Int
                city.name = cityEntity.valueForKey("name") as! String
                cities.append(city)
            }
            
            return cities
        }
        catch let error as NSError
        {
            print("Couldn't fetch \(error)")
        }
        
        return nil
    }
    
    private class func getCityEntityFromCity(city : City) -> NSManagedObject?
    {
        let managedObjectContext = DAOStorage.sharedInstance.managedObjectContext
        
        let fetchCityRequest = NSFetchRequest(entityName: "City")
        
        let predicateIdCity = NSPredicate(format: "id=%i", city.id!)
        let predicateNameCity = NSPredicate(format: "name=%@", city.name!)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateIdCity,predicateNameCity])
        
        fetchCityRequest.predicate = compoundPredicate
        
        do
        {
            let result = try managedObjectContext.executeFetchRequest(fetchCityRequest)
            return result[0] as? NSManagedObject
        }
        catch let error as NSError
        {
            print("Couldn't fetch city \(error)")
        }
        
        return nil
    }
}
