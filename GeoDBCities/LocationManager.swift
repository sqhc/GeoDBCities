//
//  LocationManager.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/27/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    var manager = CLLocationManager()
    static var shared = LocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            manager.requestLocation()
            break
        case .restricted:
            authorizationStatus = .restricted
            break
        case .denied:
            authorizationStatus = .denied
            break
        case .notDetermined:
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Latitude: \(locations[0].coordinate.latitude)")
        print("Longitude: \(locations[0].coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR: \(error.localizedDescription)")
    }
}
