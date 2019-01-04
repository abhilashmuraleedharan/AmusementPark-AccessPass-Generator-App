//
//  ParkManager.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 04/01/19.
//  Copyright © 2019 AbhilashApps. All rights reserved.
//

import Foundation

class ParkManager: Manager {
    
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var dateOfBirth: Date?
    var tier: ManagementTier?
    var socialSecurityNumber: String?
    let errorMsg = "Manager Pass"
    
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipcode: String?,
         dateOfBirth: Date?, socialSecurityNumber: String?, tier: ManagementTier?) throws {
        if let dob = dateOfBirth {
            self.dateOfBirth = dob
        } else {
            throw MissingInformationError.noDateOfBirth(errorMessage: errorMsg)
        }
        if let firstName = firstName {
            self.firstName = firstName
        } else {
            throw MissingInformationError.noFirstName(errorMessage: errorMsg)
        }
        if let lastName = lastName {
            self.lastName = lastName
        } else {
            throw MissingInformationError.noLastName(errorMessage: errorMsg)
        }
        if let streetAddress = streetAddress {
            self.streetAddress = streetAddress
        } else {
            throw MissingInformationError.noStreetAddress(errorMessage: errorMsg)
        }
        if let city = city {
            self.city = city
        } else {
            throw MissingInformationError.noCity(errorMessage: errorMsg)
        }
        if let state = state {
            self.state = state
        } else {
            throw MissingInformationError.noState(errorMessage: errorMsg)
        }
        if let zipcode = zipcode {
            self.zipcode = zipcode
        } else {
            throw MissingInformationError.noZipcode(errorMessage: errorMsg)
        }
        if let ssn = socialSecurityNumber {
            self.socialSecurityNumber = ssn
        } else {
            throw MissingInformationError.noSocialSecurityNumber(errorMessage: errorMsg)
        }
        if let managementTier = tier {
            self.tier = managementTier
        } else {
            throw MissingInformationError.noManagementTier(errorMessage: errorMsg)
        }
    }
    
}
