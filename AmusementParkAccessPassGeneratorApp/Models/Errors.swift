//
//  Errors.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

/// Defines the error types associated with lack of required personal information of Entrant as per the
/// pass type to be issued.
enum MissingInformationError : Error {
    case noDateOfBirth(errorMessage: String)
    case noFirstName(errorMessage: String)
    case noLastName(errorMessage: String)
    case noStreetAddress(errorMessage: String)
    case noCity(errorMessage: String)
    case noState(errorMessage: String)
    case noZipcode(errorMessage: String)
    case noProjectNumber(errorMessage: String)
    case noVendorCompany(errorMessage: String)
    case noDateOfVisit(errorMessage: String)
    case inSufficientData(errorMessage: String)
}

/// Defines the error types that are associated with lack of necessary qualifications for an
/// entrant to posses a specific type of pass.
enum PassEligibilityError: Error {
    case notChild(errorMessage: String)
}

