//
//  ParkEntrant.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
import Foundation

struct ParkEntrant: Entrant {
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var dateOfBirth: Date?
    
    init(firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil,
         city: String? = nil, state: String? = nil, zipcode: String? = nil, dateOfBirth: Date? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.dateOfBirth = dateOfBirth
    }
}
