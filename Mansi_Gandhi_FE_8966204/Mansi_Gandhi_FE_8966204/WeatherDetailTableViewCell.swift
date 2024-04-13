//
//  WeatherDetailTableViewCell.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//


import UIKit

// Here I created a UITableViewCell subclass named WeatherDetailTableViewCell
class WeatherDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var Temperature: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var FromWeather: UILabel!
    @IBOutlet weak var CityName: UILabel!
    

    func setup(data: WeatherCoreData) {
        WindSpeed.text = "Wind: \(data.wind ?? "")"
        Humidity.text = "Humidity: \(data.humidity ?? "")"
        Temperature.text = "Temp: \(data.temp ?? "")"
        Time.text = "Time: \(data.time ?? "")"
        Date.text = data.date ?? ""
        FromWeather.text = data.from ?? ""
        CityName.text = data.cityName ?? ""
    }
}
