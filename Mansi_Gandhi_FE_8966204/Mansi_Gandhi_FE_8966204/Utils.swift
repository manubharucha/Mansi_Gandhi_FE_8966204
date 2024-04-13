//
//  Utils.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit

// Here I created an enumeration to represent the types of data
enum SaveData: String {
    case directions = "DirectionsData"
    case news = "NewsData"
    case weather = "WeatherCoreData"
}

// here i created Function to display an alert for entering a city name.
func showCityInputAlert(on viewController: UIViewController, 
                        title: String, 
                        message: String,
                        callback: @escaping (String) -> Void) {
    let controlalert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    controlalert.addTextField { textField in
        textField.placeholder = "City name"
    }
    let actionokay = UIAlertAction(title: "OK", style: .default) { _ in
        if let txtfld = controlalert.textFields?.first, let cityName = txtfld.text {
            callback(cityName)
        }
    }
    let cnclacton = UIAlertAction(title: "Cancel", style: .cancel)
    controlalert.addAction(actionokay)
    controlalert.addAction(cnclacton)
    viewController.present(controlalert, animated: true)
}

extension UIViewController {
    var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
   }
}
// here is the Function to map weather condition ID to system icon names.
func mapWeatherConditionToSymbol(_ id: Int) -> String {
    switch id {
    case 200...232: return "cloud.bolt.rain.fill"
    case 300...321: return "cloud.drizzle.fill"
    case 500...531: return "cloud.rain.fill"
    case 600...622: return "cloud.snow.fill"
    case 701...781: return "cloud.fog.fill"
    case 800: return "sun.max.fill"
    case 801...804: return "cloud.fill"
    default: return "questionmark.circle"
    }
}

// created a  Extension to Date to get current date and time.
extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }
    
    func currentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}



