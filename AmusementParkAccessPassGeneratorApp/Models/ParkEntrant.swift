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
    let vendorPassErrorMsg = "Vendor Pass"
    let contractorPassErrorMsg = "Contractor Pass"
    
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
        case .project1001ContractorPass, .project1002ContractorPass, .project1003ContractorPass, .project2001ContractorPass, .project2002ContractorPass:
            if let dob = dateOfBirth {
                self.dateOfBirth = dob
            } else {
                throw MissingInformationError.noDateOfBirth(errorMessage: contractorPassErrorMsg)
            }
            if let firstName = firstName {
                self.firstName = firstName
            } else {
                throw MissingInformationError.noFirstName(errorMessage: contractorPassErrorMsg)
            }
            if let lastName = lastName {
                self.lastName = lastName
            } else {
                throw MissingInformationError.noLastName(errorMessage: contractorPassErrorMsg)
            }
            if let streetAddress = streetAddress {
                self.streetAddress = streetAddress
            } else {
                throw MissingInformationError.noStreetAddress(errorMessage: contractorPassErrorMsg)
            }
            if let city = city {
                self.city = city
            } else {
                throw MissingInformationError.noCity(errorMessage: contractorPassErrorMsg)
            }
            if let state = state {
                self.state = state
            } else {
                throw MissingInformationError.noState(errorMessage: contractorPassErrorMsg)
            }
            if let zipcode = zipcode {
                self.zipcode = zipcode
            } else {
                throw MissingInformationError.noZipcode(errorMessage: contractorPassErrorMsg)
            }
            if let projectNo = projectNumber {
                self.projectNumber = projectNo
            } else {
                throw MissingInformationError.noProjectNumber(errorMessage: contractorPassErrorMsg)
            }
        case .acmeCompanyVendorPass, .fedexCompanyVendorPass, .orikinCompanyVendorPass, .nwelectricalCompanyVendorPass:
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
            if let company = vendorCompany {
                self.vendorCompany = company
            } else {
                throw MissingInformationError.noVendorCompany(errorMessage: "\(associatedPassType.rawValue)")
            }
            if let dov = dateOfVisit {
                self.dateOfVisit = dov
            } else {
                throw MissingInformationError.noDateOfVisit(errorMessage: "\(associatedPassType.rawValue)")
            }
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
        }
    }
}

