//
//  ContractEmployeePass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 29/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class ContractEmployeePass: ParkPass, Swipable {
    
    private let projectNumberPassTypeDictionary: [String: PassSubType] = [
        "1001": .project1001ContractEmployeePass,
        "1002": .project1002ContractEmployeePass,
        "1003": .project1003ContractEmployeePass,
        "2001": .project2001ContractEmployeePass,
        "2002": .project2002ContractEmployeePass
    ]
    
    init(projectNumber: String?, firstName: String?, lastName: String?,
         streetAddress: String?, city: String?,
         state: String?, zipcode: String?,
         dateOfBirth: Date?) throws {
        do {
            guard let contractProjectNumber = projectNumber else {
                throw MissingInformationError.noProjectNumber(errorMessage: "Contract Employee Pass requires associated contract project number.")
            }
            guard let passType = projectNumberPassTypeDictionary[contractProjectNumber] else {
                throw DataError.invalidProjectNumber(errorMessage: "Project Number not recognized! Contract Employee Pass requires a valid project number.")
            }
            try super.init(passType: passType, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress,
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth, projectNumber: projectNumber, vendorCompany: nil, dateOfVisit: nil, type: nil)
            printPassGenerationStatus()
        } catch MissingInformationError.inSufficientData(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch MissingInformationError.noProjectNumber(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch DataError.invalidProjectNumber(let error) {
            throw DataError.invalidProjectNumber(errorMessage: error)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
}
