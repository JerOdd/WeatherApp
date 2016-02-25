//
//  UICitiesSplitViewController.swift
//  WeatherApp
//
//  Copyright © 2016 JerOdd. All rights reserved.
//

import UIKit

class UICitiesSplitViewController: UISplitViewController, UISplitViewControllerDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool
    {
        // Always display the list of cities, if false it displays the description...
        return true
    }
}
