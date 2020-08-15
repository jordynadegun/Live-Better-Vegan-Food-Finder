//
//  ViewController.swift
//  Live Better Final Project
//
//  Created by Jordyn Adegun on 7/24/20.
//  Copyright © 2020 Jordyn Adegun. All rights reserved.
//

import UIKit
import Firebase
import MapKit


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var addRestaurantButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
                print("Error signing out")
        }
    }
    
    
    let locationManager = CLLocationManager()
    var mapHasCenteredOnce = false
    private var restaurantCollectionRef: CollectionReference!
    
    var restaurants: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        restaurantCollectionRef = Firestore.firestore().collection("Restaurants Philadelphia")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        ActivityIndicator.start()
        
        restaurantCollectionRef.getDocuments { (snapshot, error) in
            
            ActivityIndicator.stop()

            if let err = error {
                debugPrint("Error getting data: \(err)")
            } else {
                for document in (snapshot?.documents)! {
                    
                   // print(document.data())
                    let data = document.data()
                    let name = data["Restaurant"] as? String
                    let address = data["Address"] as? String
                    let website = data["Website"] as? String
                    let hours = data["Hours"] as? String
                    let phone = data["Phone"] as? String
                    let longitude = data["Longitude"] as? String
                    let latitude = data["Latitude"] as? String
                    
                    self.restaurants.append(Restaurant(id: UUID().uuidString, name: name, address: address, website: website, hours: hours, phoneNumber: phone, longitude: longitude, latitude: latitude))
                }
                
                self.addRestaurantsToMap()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool){
        locationAuthStatus()
    }
    
    private func addRestaurantsToMap() {
        
        for restaurant in restaurants {
         
            guard let latitude = restaurant.latitude, let longitude = restaurant.longitude else { continue }
            
            let marker = RestaurantMarker(coordinate: CLLocationCoordinate2D(latitude: (latitude as NSString).doubleValue, longitude: (longitude as NSString).doubleValue))
            marker.title = restaurant.name
            marker.restaurant = restaurant
            mapView.addAnnotation(marker)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let marker = view.annotation as? RestaurantMarker, let restaurant = marker.restaurant else { return }

        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "restaurantDetailsVC") as! RestaurantDetailsViewController
        detailsVC.restaurant = restaurant
        self.present(detailsVC, animated: true, completion: nil)
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager:CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    //  Our function used to set the screen into center of present location
    func centerMapOnLocation(Location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: Location.coordinate,latitudinalMeters: 2000,longitudinalMeters: 2000)
        
        // Use setRegion Method so as to set position and zoom level of our screen.
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            
            // 7.Check if this is the first opening map, set screen into the present location.
            if !mapHasCenteredOnce {
                centerMapOnLocation(Location: loc)
                mapHasCenteredOnce = true
            }
        }
    }
}
