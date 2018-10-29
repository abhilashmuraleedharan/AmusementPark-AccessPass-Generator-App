//
//  ParkEntrant.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
import Foundation

class ParkEntrant: Entrant {
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var dateOfBirth: Date?
    
    required init(selectedPassType: PassSubCategory, firstName: String?, lastName: String?,
                  streetAddress: String?, city: String?, state: String?, zipcode: String?,
                  dateOfBirth: Date?) throws {
        switch selectedPassType {
        case .classicGuestPass, .vipGuestPass:
            self.firstName = firstName
            self.lastName = lastName
            self.streetAddress = streetAddress
            self.city = city
            self.state = state
            self.zipcode = zipcode
            self.dateOfBirth = dateOfBirth
        case .freeChildGuestPass:
            self.firstName = firstName
            self.lastName = lastName
            self.streetAddress = streetAddress
            self.city = city
            self.state = state
            self.zipcode = zipcode
            if dateOfBirth == nil {
                throw MissingInformationError.missingDateOfBirth(error: "\(selectedPassType.rawValue)")
            }
        default:
            self.dateOfBirth = dateOfBirth
            if firstName == nil {
                throw MissingInformationError.missingFirstName(error: "\(selectedPassType.rawValue)")
            }
            if lastName == nil {
                throw MissingInformationError.missingLastName(error: "\(selectedPassType.rawValue)")
            }
            if streetAddress == nil {
                throw MissingInformationError.missingStreetAddress(error: "\(selectedPassType.rawValue)")
            }
            if city == nil {
                throw MissingInformationError.missingCity(error: "\(selectedPassType.rawValue)")
            }
            if state == nil {
                throw MissingInformationError.missingState(error: "\(selectedPassType.rawValue)")
            }
            if zipcode == nil {
                throw MissingInformationError.missingZipcode(error: "\(selectedPassType.rawValue)")
            }
        }
    }
}

