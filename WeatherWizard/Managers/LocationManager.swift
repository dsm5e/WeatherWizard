//
//  LocationManager.swift
//  WeatherWizard
//
//  Created by dsm 5e on 03.08.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var placemark: CLPlacemark?
    @Published var userLocation: CLLocation?
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
        
        guard let location = locations.last else { return }
        self.userLocation = location
        
        let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(userLocation!) { placemarks, error in
              self.placemark = placemarks?.last
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}
