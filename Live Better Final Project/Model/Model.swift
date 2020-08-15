//
//  Model.swift
//  Live Better Final Project
//
//  Created by Harshana Ekanayake on 8/7/20.
//  Copyright © 2020 Jordyn Adegun. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    var id: String
    var name: String?
    var address: String?
    var website: String?
    var hours: String?
    var phoneNumber: String?
    var longitude: String?
    var latitude: String?
}

class RestaurantMarker: NSObject, MKAnnotation {
    var title: String?
    var addr: String?
    var coordinate: CLLocationCoordinate2D
    var info: String?
    var subtitle: String?
    var restaurant: Restaurant?
    
    init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D, info: String? = nil, restaurant: Restaurant? = nil) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.subtitle = subtitle
        self.restaurant = restaurant
    }
}
