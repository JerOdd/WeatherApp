//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?
    var mainTabBarViewController : UITabBarController? // The main tab bar controller
    var citiesSplitViewController : UICitiesSplitViewController? // The split view controller
    var citiesTableViewController : UICitiesTableViewController? // The cities table view controller
    var citiesDescriptionViewController : UICitiesDescriptionViewController? // The city weather description controller
    var favoritesTableViewController : UIFavoritesTableViewController? // The favorites table view controller

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // Get all the instances of viewControllers set in Main.storyboard
        mainTabBarViewController = window?.rootViewController as? UITabBarController
        citiesSplitViewController = mainTabBarViewController?.viewControllers?.first as? UICitiesSplitViewController
        let leftNavigationController = citiesSplitViewController!.viewControllers.first as? UINavigationController
        citiesTableViewController = leftNavigationController!.topViewController as? UICitiesTableViewController
        citiesDescriptionViewController = citiesSplitViewController!.viewControllers.last as? UICitiesDescriptionViewController
        favoritesTableViewController = mainTabBarViewController?.viewControllers?.last as? UIFavoritesTableViewController
        
        // Initialization of all cities saved in the favourites
        BOCityManager.sharedManager.getAllSavedCities()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}

