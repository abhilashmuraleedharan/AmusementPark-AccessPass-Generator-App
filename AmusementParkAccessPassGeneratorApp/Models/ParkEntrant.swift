//
//  ParkEntrant.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
import Foundation

class ParkEntrant: Entrant, Vendor, Contractor {
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var dateOfBirth: Date?
    var projectNumber: String?
    var vendorCompany: String?
    var dateOfVisit: Date?
    let vendorEntrantErrorMsg = "Vendor Pass"
    
    init(associatedPassType: PassSubType, firstName: String?, lastName: String?,
                  streetAddress: String?, city: String?, state: String?, zipcode: String?,
                  dateOfBirth: Date?, projectNumber: String?, vendorCompany: String?, dateOfVisit: Date?) throws {
        switch associatedPassType {
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
            if let dob = dateOfBirth {
                self.dateOfBirth = dob
            } else {
                throw MissingInformationError.noDateOfBirth(errorMessage: "\(associatedPassType.rawValue)")
            }
        case .seniorGuestPass:
            if let dob = dateOfBirth {
                self.dateOfBirth = dob
            } else {
                throw MissingInformationError.noDateOfBirth(errorMessage: "\(associatedPassType.rawValue)")
            }
            if let firstName = firstName {
                self.firstName = firstName
            } else {
                throw MissingInformationError.noFirstName(errorMessage: "\(associatedPassType.rawValue)")
            }
            if let lastName = lastName {
                self.lastName = lastName
            } else {
                throw MissingInformationError.noLastName(errorMessage: "\(associatedPassType.rawValue)")
            }
            self.streetAddress = streetAddress
            self.city = city
            self.state = state
            self.zipcode = zipcode
        case .acmeCompanyVendorPass, .fedexCompanyVendorPass, .orkinCompanyVendorPass, .nwelectricalCompanyVendorPass:
            if let dob = dateOfBirth {
                self.dateOfBirth = dob
            } else {
                throw MissingInformationError.noDateOfBirth(errorMessage: vendorEntrantErrorMsg)
            }
            if let firstName = firstName {
                self.firstName = firstName
            } else {
                throw MissingInformationError.noFirstName(errorMessage: vendorEntrantErrorMsg)
            }
            if let lastName = lastName {
                self.lastName = lastName
            } else {
                throw MissingInformationError.noLastName(errorMessage: vendorEntrantErrorMsg)
            }
            if let dov = dateOfVisit {
                self.dateOfVisit = dov
            } else {
                throw MissingInformationError.noDateOfVisit(errorMessage: vendorEntrantErrorMsg)
            }
            self.vendorCompany = vendorCompany
            self.streetAddress = streetAddress
            self.city = city
            self.state = state
            self.zipcode = zipcode
        default:
            if let dob = dateOfBirth {
                self.dateOfBirth = dob
            } else {
                throw MissingInformationError.noDateOfBirth(errorMessage: "\(associatedPassType.rawValue)")
            }
            if let firstName = firstName {
                self.firstName = firstName
            } else {
                throw MissingInformationError.noFirstName(errorMessage: "\(associatedPassType.rawValue)")
            }
            if let lastName = lastName {
                self.lastName = lastName
            } else {
                throw MissingInformationError.noLastName(errorMessage: "\(associatedPassType.rawValue)")
            }
            if let streetAddress = streetAddress {
                self.streetAddress = streetAddress
            } else {
                throw MissingInformationError.noStreetAddress(errorMessage: "\(associatedPassType.rawValue)")
            }
            if let city = city {
                self.city = city
            } else {
                throw MissingInformationError.noCity(errorMessage: "\(associatedPassType.rawValue)")
            }
            if let state = state {
                self.state = state
            } else {
                throw MissingInformationError.noState(errorMessage: "\(associatedPassType.rawValue)")
            }
            if let zipcode = zipcode {
                self.zipcode = zipcode
            } else {
                throw MissingInformationError.noZipcode(errorMessage: "\(associatedPassType.rawValue)")
            }
            self.projectNumber = projectNumber
        }
    }
}

