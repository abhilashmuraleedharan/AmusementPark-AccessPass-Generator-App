//
//  ParkContractor.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 04/01/19.
//  Copyright © 2019 AbhilashApps. All rights reserved.
//

import Foundation

class ParkContractor: ContractEmployee {
    
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var dateOfBirth: Date?
    var projectNumber: String?
    var socialSecurityNumber: String?
    let errorMsg = "Contract Employee Pass"
    
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipcode: String?,
         dateOfBirth: Date?, projectNumber: String?, socialSecurityNumber: String?) throws {
        
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
        if let projectNo = projectNumber {
            self.projectNumber = projectNo
        } else {
            throw MissingInformationError.noProjectNumber(errorMessage: errorMsg)
        }
        if let ssn = socialSecurityNumber {
            self.socialSecurityNumber = ssn
        } else {
            throw MissingInformationError.noSocialSecurityNumber(errorMessage: errorMsg)
        }
    }
    
}
