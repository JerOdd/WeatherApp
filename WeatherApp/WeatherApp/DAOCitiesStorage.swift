//
//  DAOCitiesStorage.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import Foundation

import CoreData

class DAOCitiesStorage: NSObject
{
    static let managedObjectContext = DAOStorage.sharedInstance.managedObjectContext
    
    //MARK: - Save the city
    
    /**
     * Save the city in the database
     * - Parameter city: the city
     */
    class func saveCity(city: City)
    {
        // Init the entity
        let cityEntity = NSEntityDescription.entityForName("City", inManagedObjectContext: managedObjectContext)
        
        // Init the managedObject and set values
        let cityObject = NSManagedObject(entity: cityEntity!, insertIntoManagedObjectContext: managedObjectContext)
        cityObject.setValue(city.name, forKey: "name")
        cityObject.setValue(city.id, forKey: "id")
        
        // Save the context
        DAOStorage.sharedInstance.saveContext()
    }
    
    //MARK: - Remove the city
    
    /**
     * Remove the city in the database
     * - Parameter city: the city
     */
    class func removeCity(city: City)
    {
        // Init the managed object with the city
        let cityManagedObject = getCityManagedObjectFromCity(city)
        
        // Delete the city from the context
        managedObjectContext.deleteObject(cityManagedObject!)
        
        // Save the context
        DAOStorage.sharedInstance.saveContext()
    }
    
    //MARK: - Fetch request for the cities
    
    /**
     * Fetch all the cities saved in the database
     * - Returns: an array of cities
     */
    class func getAllSavedCities() -> Array<City>?
    {
        let fetchCitiesRequest = NSFetchRequest(entityName: "City")
        
        do
        {
            let cityEntities = try managedObjectContext.executeFetchRequest(fetchCitiesRequest) as! [NSManagedObject]
            
            var cities : Array<City> = Array<City>() // Array which will contain all the saved cities
            
            for cityEntity in cityEntities
            {
                // Create a city with a city managed object
                let city : City = City()
                city.id = cityEntity.valueForKey("id") as? Int
                city.name = cityEntity.valueForKey("name") as! String
                
                // Add the city to the array
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
    
    /**
     * Parse a city into a city managed object
     * - Parameter city: The city
     * - Return: A managedObject associated to the city or nil
     */
    private class func getCityManagedObjectFromCity(city : City) -> NSManagedObject?
    {
        let fetchCityRequest = NSFetchRequest(entityName: "City")
        
        // Creation of predicates to fetch the good city
        let predicateIdCity = NSPredicate(format: "id=%i", city.id!)
        let predicateNameCity = NSPredicate(format: "name=%@", city.name!)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateIdCity,predicateNameCity])
        fetchCityRequest.predicate = compoundPredicate
        
        do
        {
            let result = try managedObjectContext.executeFetchRequest(fetchCityRequest)
            
            if result.count > 0
            {
                return result[0] as? NSManagedObject // There is only one possible result
            }
        }
        catch let error as NSError
        {
            print("Couldn't fetch city \(error)")
        }
        
        return nil // That normally can't happen
    }
}
