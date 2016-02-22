//
//  UICitiesTableViewCell.swift
//  WeatherApp
//
//  Created by Cyrielle Gandon on 22/02/2016.
//  Copyright © 2016 Jeremy ODDOS. All rights reserved.
//

import UIKit

class UICitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
