//
//  ContractEmployeePass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 29/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class ContractEmployeePass: ParkPass, Swipable {
    
    init(projectNumber: String?, firstName: String?, lastName: String?,
         streetAddress: String?, city: String?,
         state: String?, zipcode: String?,
         dateOfBirth: Date?) throws {
        do {
            guard let contractProjectNumber = projectNumber else {
                throw MissingInformationError.noProjectNumber(errorMessage: "Contract Employee Pass requires associated contract project number.")
            }
            guard let project = ContractorPass.init(rawValue: contractProjectNumber) else {
                throw ValidationError.invalidProjectNumber(errorMessage: "Project Number not recognized! Contract Employee Pass requires a valid project number.")
            }
            try super.init(passType: project.associatedPassType, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress,
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth, projectNumber: projectNumber, vendorCompany: nil, dateOfVisit: nil, tier: nil)
            printPassGenerationStatus()
        } catch MissingInformationError.inSufficientData(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch MissingInformationError.noProjectNumber(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch ValidationError.invalidProjectNumber(let error) {
            throw ValidationError.invalidProjectNumber(errorMessage: error)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
    
}
