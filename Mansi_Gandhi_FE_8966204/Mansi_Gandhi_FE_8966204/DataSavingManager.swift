//
//  DataSavingManager.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//


import UIKit
import CoreData

class DataSavingManager {
    static let shared = DataSavingManager()
    
    private init() {}
    
    // here i created Method to save direction data.
    func saveDirection(cityName: String, distance: String, from: String, method: String, startPoint: String, endPoint: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // here i Create a new DirectionsData object
        let direction = DirectionsData(context: context)
        direction.citynames = cityName
        direction.totaldistance = distance
        direction.from = from
        direction.methodoftravel = method
        direction.datatypes = SaveData.directions.rawValue
        direction.startingpoint = startPoint
        direction.endPoint = endPoint
        do {
            try context.save()
        } catch {
            print("Failed to save direction: \(error.localizedDescription)")
        }
    }

    //here i created  Method to perform initial setup on first launch.
    func firstCheckMethod() {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "firstLaunch") {
            defaults.set(true, forKey: "firstLaunch")
            defaults.synchronize()
            let cities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix"]
            for city in cities {
                saveNews(author: "Anonymous", cityName: city, content: "Sample news content", from: "Local News", source: "Sample Source", title: "Sample News Title")
            }
        }
    }
    
    
    // here i created Method to save news data.
    func saveNews(author: String, cityName: String, content: String, from: String, source: String, title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let news = NewsData(context: context)
        news.authorofnews = author
        news.nameofcity = cityName
        news.content = content
        news.from = from
        news.source = source
        news.titleofnews = title
        news.typedata = SaveData.news.rawValue

        do {
            try context.save()
        } catch {
            print("Failed to save news: \(error.localizedDescription)")
        }
    }

    // here i created Method to save weather data.
    func saveWeather(cityName: String, date: String, humidity: String, temp: String, time: String, wind: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let weather = WeatherCoreData(context: context)
        weather.cityName = cityName
        weather.date = date
        weather.humidity = humidity
        weather.temp = temp
        weather.time = time
        weather.wind = wind
        weather.dataType = SaveData.weather.rawValue
        
        do {
            try context.save()
        } catch {
            print("Failed to save weather: \(error.localizedDescription)")
        }
    }
}
