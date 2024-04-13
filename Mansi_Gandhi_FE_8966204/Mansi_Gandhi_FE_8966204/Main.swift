//
//  Main.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit
import MapKit

class Main: UIViewController, MKMapViewDelegate, UITabBarDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapview: MKMapView!
    
    @IBOutlet weak var Temperature: UILabel!
    
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    
    @IBOutlet weak var imageweather: UIImageView!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "My Final", style: .plain, target: nil, action: nil)
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        mapview.delegate = self
        mapview.showsUserLocation = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        if sender.tag == 2 {
            if let destination = segue.destination as? UITabBarController {
                destination.selectedIndex = 1
            }
        } else if sender.tag == 3 {
            if let destination = segue.destination as? UITabBarController {
                destination.selectedIndex = 2
            }
        }
    }
    // Here I created a method to update the user interface with weather data.
    func updateUI(with data: WeatherModel) {
        Temperature.text = "\(Int(data.main.temp))°C"
        windSpeed.text = "Wind: \(data.wind.speed)Km/h"
        Humidity.text = "Humidity: \(data.main.humidity)"
        imageweather.image = UIImage(systemName: mapWeatherConditionToSymbol(data.weather.first?.id ?? 0))
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let hidde = (viewController is Main)
        navigationController.setNavigationBarHidden(hidde, animated: animated)
    }
    // Here I created a method to handle the location manager's didFailWithError event, which prints out an error message when location fetching fails.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error fetching location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapview.setRegion(region, animated: true)
        fetchWeatherData(for: location.coordinate)
    }
    
    
    // Here I created a private method to fetch weather data for a given coordinate.
    private func fetchWeatherData(for coordinate: CLLocationCoordinate2D) {
        let apiKey = "d12cf7d594efca14ca2553dd7af64374" 
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let decode = JSONDecoder()
                let weatherData = try decode.decode(WeatherModel.self, from: data)
                
                DispatchQueue.main.async {
                    self?.updateUI(with: weatherData)
                }
            } catch {
                print("Error decoding weather data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
