//
//  Map.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//


import UIKit
import MapKit

class Map: UIViewController,
           MKMapViewDelegate,
           CLLocationManagerDelegate {
    
    @IBOutlet weak var SBar: UISlider!
    @IBOutlet weak var mapview: MKMapView!
   
    let loc = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var destinationLocation: CLLocationCoordinate2D?
    var destinationCityName = ""
    var currentCityName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.delegate = self
        loc.delegate = self
        loc.requestWhenInUseAuthorization()
        loc.startUpdatingLocation()
        setupSlider()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarButton
    }
    // Here I created a private method to set up the slider.
    private func setupSlider() {
        SBar.minimumValue = 0.0
        SBar.maximumValue = 1.0
        SBar.value = 0.5
        SBar.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    // Here I created a method to prompt the user to input a city name.
    func gtCtyName() {
        showCityInputAlert(on: self,
                           title: "Enter City",
                           message: "Type the name of the city") { cityName in
            self.lookupCity(cityName: cityName)
            self.destinationCityName = cityName
        }
    }
    // Here I created a method to handle tapping the right bar button item.
    @objc func rightBarButtonTapped() {
        gtCtyName()
    }
    
    // Here I created a method to handle slider value changes.
    @objc func sliderValueChanged(_ sender: UISlider) {
        let region = MKCoordinateRegion(center: mapview.centerCoordinate, latitudinalMeters: CLLocationDistance(10000 - sender.value * 10000), longitudinalMeters: CLLocationDistance(10000 - sender.value * 10000))
        mapview.setRegion(mapview.regionThatFits(region), animated: true)
    }
    
    private func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let Annotations = MKPointAnnotation()
        Annotations.coordinate = coordinate
        mapview.addAnnotation(Annotations)
        let Regions = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000/2, longitudinalMeters: 10000/2)
        mapview.setRegion(Regions, animated: true)
    }
    
    // Here I created a private method to look up the city based on the provided city name.
    private func lookupCity(cityName: String) {
        let Geocode = CLGeocoder()
        Geocode.geocodeAddressString(cityName) { [weak self] (placemarks, error) in
            guard let strongSelf = self else { return }
            if let Markplace = placemarks?.first, let location = Markplace.location {
                strongSelf.destinationLocation = location.coordinate
                strongSelf.addAnnotationAtCoordinate(coordinate: location.coordinate)
                strongSelf.getDirections(transportType: .automobile)
            }
        }
    }
    
    
    
    private func getDirections(transportType: MKDirectionsTransportType) {
        guard let startLocation = currentLocation, let endLocation = destinationLocation else { return }
        let Startplace = MKPlacemark(coordinate: startLocation)
        let EndPlace = MKPlacemark(coordinate: endLocation)
        
        let Mapitemstart = MKMapItem(placemark: Startplace)
        let endMapItem = MKMapItem(placemark: EndPlace)
        
        let Requestfordirection = MKDirections.Request()
        Requestfordirection.source = Mapitemstart
        Requestfordirection.destination = endMapItem
        Requestfordirection.transportType = transportType
        
        // Here I created a method to calculate directions 
        let direct = MKDirections(request: Requestfordirection)
        direct.calculate { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if let Routed = response?.routes.first {
                strongSelf.mapview.removeOverlays(strongSelf.mapview.overlays)
                strongSelf.mapview.addOverlay(Routed.polyline, level: .aboveRoads)
                let rect = Routed.polyline.boundingMapRect
                strongSelf.mapview.setRegion(MKCoordinateRegion(rect), animated: true)
                let distance = Routed.distance
                let distanceKilometer = distance / 1000
                let strngdistance = String(format: "%.2f km", distanceKilometer)
                
                DataSavingManager.shared.saveDirection(cityName: EndPlace.locality ?? "",
                                                     distance: strngdistance,
                                                     from: "Map",
                                                     method: transportType == .automobile ? "Car" : "Walk",
                                                     startPoint: self?.currentCityName ?? "",
                                                     endPoint: self?.destinationCityName ?? "")
            }
        }
    }
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location.coordinate
            manager.stopUpdatingLocation()
            addAnnotationAtCoordinate(coordinate: location.coordinate)
            getCurrentCityName(for: location) { city in
                self.currentCityName = city ?? ""
            }
        }
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let rende = MKPolylineRenderer(overlay: overlay)
            rende.strokeColor = UIColor.blue
            rende.lineWidth = 4.0
            return rende
        }
        return MKOverlayRenderer()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // Here I created IBAction methods to handle tapping the car and walk buttons for getting directions.
    @IBAction func carTapped(_ sender: Any) {
        getDirections(transportType: .automobile)
    }
    @IBAction func walkTapped(_ sender: Any) {
        getDirections(transportType: .walking)
    }
    
    // Here I created a method to get the current city name for a given location.

    func getCurrentCityName(for location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error getting city name: \(error)")
                completion(nil)
            } else if let placemark = placemarks?.first {
                let city = placemark.locality
                completion(city)
            } else {
                print("Placemark not found")
                completion(nil)
            }
        }
    }
}
