//
//  MissinginformationErrors.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

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

