//
//  Weather.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit

// Here I created a UIViewController subclass to display weather information.
class Weather: UIViewController {

    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var Temp: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Weather"
        fetchWeatherData(for: "Waterloo")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Creating a UIBarButtonItem with a "+" image for adding city name.
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(rightBttnTapped))
        // Set the right bar button item of the navigation item.
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarButton
    }
    // here i created Method to handle tapping the right bar button item to input city name for weather.
    @objc func rightBttnTapped() {
        showCityInputAlert(on: self, title: "Enter City Name", message: "Please enter the name of the city:") { [weak self] cityName in
            self?.fetchWeatherData(for: cityName)
        }
    }
    
    // here i created Method to save weather data.
    func Weather(data: WeatherModel) {
        DataSavingManager.shared.saveWeather(cityName: data.name,
                                date: Date.getCurrentDate(),
                                humidity: "\(data.main.humidity)%",
                                temp: "\(Int(data.main.temp))°C",
                                time: Date().currentTime(),
                                wind: "\(data.wind.speed) km/h")
    }
    // here i created Method to update the UI with weather data.
    private func updateUI(with weatherData: WeatherModel) {
        cityName.text = weatherData.name
        Description.text = weatherData.weather.first?.description ?? "N/A"
        Temp.text = "\(Int(weatherData.main.temp))°C"
        humidity.text = "Humidity: \(weatherData.main.humidity)%"
        WindSpeed.text = "Wind: \(weatherData.wind.speed) km/h"
        Weather(data: weatherData)
    }
    
    // Here I created a method to fetch weather data for a given city using the OpenWeatherMap API.
    private func fetchWeatherData(for city: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=d12cf7d594efca14ca2553dd7af64374&units=metric") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self?.updateUI(with: weatherData)
                }
            } catch {
                print("Error decoding weather data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
