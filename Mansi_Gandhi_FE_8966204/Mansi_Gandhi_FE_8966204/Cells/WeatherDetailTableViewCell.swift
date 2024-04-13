//
//  WeatherDetailTableViewCell.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var windspeedlbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var ctynamelbl: UILabel!
    

    func setup(data: WeatherCoreData) {
        windspeedlbl.text = "Wind: \(data.wind ?? "")"
        humidityLbl.text = "Humidity: \(data.humidity ?? "")"
        tempLbl.text = "Temp: \(data.temp ?? "")"
        timeLbl.text = "Time: \(data.time ?? "")"
        dateLbl.text = data.date ?? ""
        fromLbl.text = data.from ?? ""
        ctynamelbl.text = data.cityName ?? ""
    }
}
