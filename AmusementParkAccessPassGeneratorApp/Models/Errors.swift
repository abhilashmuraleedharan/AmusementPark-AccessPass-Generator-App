//
//  Errors.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

/// Defines the error types associated with lack of required personal information as per the
/// pass type, to be issued to an entrant.
enum MissingInformationError : Error {
    case missingDateOfBirth(error: String)
    case missingFirstName(error: String)
    case missingLastName(error: String)
    case missingStreetAddress(error: String)
    case missingCity(error: String)
    case missingState(error: String)
    case missingZipcode(error: String)
    case incompleteData(error: String)
}

/// Defines the eror types that are associated with lack of neccesary qualification of an
/// entrant to posses a specific type of pass.
enum PassQualificationError: Error {
    case notChild(error: String)
}

