//
//  ParkVendor.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 05/01/19.
//  Copyright © 2019 AbhilashApps. All rights reserved.
//

import Foundation

class ParkVendor: Vendor {
    
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var dateOfBirth: Date?
    var socialSecurityNumber: String?
    var vendorCompany: String?
    var dateOfVisit: Date?
    let errorMsg = "Vendor Pass"
    
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipcode: String?,
         dateOfBirth: Date?, vendorCompany: String?, dateOfVisit: Date?, socialSecurityNumber: String?) throws {
        
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
        if let dov = dateOfVisit {
            self.dateOfVisit = dov
        } else {
            throw MissingInformationError.noDateOfVisit(errorMessage: errorMsg)
        }
        if let name = vendorCompany {
            self.vendorCompany = name
        } else {
            throw MissingInformationError.noVendorCompany(errorMessage: errorMsg)
        }
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.socialSecurityNumber = socialSecurityNumber
    }
    
}
