//
//  UICitiesDescriptionViewController.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 23/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

class UICitiesDescriptionViewController: UIViewController
{
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadDisplayWithWeather(weather : Weather, andWeatherImage weatherImage : UIImage)
    {
        weatherDescriptionLabel.text = weather.desc
        weatherImageView.image = weatherImage
    }
}
