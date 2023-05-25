//
//  LocationSearch.swift
//  Karlaban
//
//  Created by Sekarwulan on 23/05/23.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate{
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    @Published var currentLocation: CLLocation?
    
    //Search Bar Text
    @Published var searchText: String = ""
    var cancellable: AnyCancellable?
    @Published var fetchedPlaces: [CLPlacemark]?
    
    override init() {
        super.init()
        //Setting Delegates
        manager.delegate = self
        mapView.delegate = self
        
        //Request Location
        manager.requestWhenInUseAuthorization()
        
        //Distance
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: {value in
                self.fetchPlaces(value: value)
            })
    }
    func fetchPlaces(value: String){
        Task{
            do{
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()
                
                let response = try await MKLocalSearch(request: request).start()
                await MainActor.run(body: {
                    self.fetchedPlaces = response.mapItems.compactMap({item -> CLPlacemark in return item.placemark
                        
                    })
                })
            }
            catch{
                
            }
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        //Handle Error
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let _ = locations.last else{return}
    }
            
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case .authorizedAlways: manager.requestLocation()
        case .authorizedWhenInUse: manager.requestLocation()
        case .denied: handleLocationError()
        case .notDetermined: manager.requestWhenInUseAuthorization()
        default: ()
        }
    }
    func handleLocationError(){
        
    }
    func calculateDistance(to location: CLLocation) -> CLLocationDistance? {
            guard let currentLocation = currentLocation else {
                return nil
            }
            return currentLocation.distance(from: location)
        }
}

