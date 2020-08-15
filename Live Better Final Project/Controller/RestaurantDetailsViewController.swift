//
//  RestaurantDetailsViewController.swift
//  Live Better Final Project
//
//  Created by Harshana Ekanayake on 8/7/20.
//  Copyright © 2020 Jordyn Adegun. All rights reserved.
//

import UIKit
import Contacts

class RestaurantDetailsViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var openingHoursLbl: UILabel!
    @IBOutlet weak var phoneNumberBtn: UIButton!
    @IBOutlet weak var webSiteBtn: UIButton!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = restaurant.name
        addressBtn.setTitle(restaurant.address, for: .normal)
        openingHoursLbl.text = restaurant.hours
        phoneNumberBtn.setTitle(restaurant.phoneNumber, for: .normal)
        webSiteBtn.setTitle(restaurant.website, for: .normal)
        
        addressBtn.underline(color: .systemYellow)
        phoneNumberBtn.underline(color: .systemYellow)
        webSiteBtn.underline(color: .systemYellow)

        // Reverse geocode location if the database does not provide the address
        if (restaurant.address == nil || restaurant.address == "") {
            getRestaurantAddress()
        }
    }
    
    private func getRestaurantAddress() {
        
        guard let latitude = restaurant.latitude, let longitude = restaurant.longitude else { return }

        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: (latitude as NSString).doubleValue, longitude: (longitude as NSString).doubleValue)
        
        ActivityIndicator.start()

        geocoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in

            ActivityIndicator.stop()

            if let placemarkArray = placemarks {
                if let placeMark = placemarkArray.first {
                    self.addressBtn.setTitle(placeMark.address, for: .normal)
                    self.addressBtn.underline(color: .systemYellow)
                } else {
                    print("Address not found")
                }
            } else {
                print("Address not found")
            }
        })
    }
    
    @IBAction func addressTapped(_ sender: Any) {
        
        guard let latitude = restaurant.latitude, let longitude = restaurant.longitude else { return }

        let coordinate = CLLocationCoordinate2D(latitude: (latitude as NSString).doubleValue, longitude: (longitude as NSString).doubleValue)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = restaurant.name
        
        let regionDistance:CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)

        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]

        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBAction func phoneNumberTapped(_ sender: Any) {
        
        if let phone = restaurant.phoneNumber, let url = NSURL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL)
        }
    }
    
    @IBAction func websiteTapped(_ sender: Any) {
        
        if let website = restaurant.website, let url = NSURL(string: website), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL)
        }
    }
}
