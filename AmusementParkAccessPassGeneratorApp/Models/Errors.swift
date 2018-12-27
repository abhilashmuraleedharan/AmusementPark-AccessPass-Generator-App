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
    case missingDateOfBirth(errorMessage: String)
    case missingFirstName(errorMessage: String)
    case missingLastName(errorMessage: String)
    case missingStreetAddress(errorMessage: String)
    case missingCity(errorMessage: String)
    case missingState(errorMessage: String)
    case missingZipcode(errorMessage: String)
    case missingProjectNumber(errorMessage: String)
    case missingVendorCompany(errorMessage: String)
    case missingDateOfVisit(errorMessage: String)
    case incompleteData(errorMessage: String)
}

/// Defines the error types that are associated with lack of necessary qualifications for an
/// entrant to posses a specific type of pass.
enum PassQualificationError: Error {
    case notChild(errorMessage: String)
}

