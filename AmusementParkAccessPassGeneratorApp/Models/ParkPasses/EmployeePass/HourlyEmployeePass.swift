//
//  HourlyEmployeePass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 05/01/19.
//  Copyright © 2019 AbhilashApps. All rights reserved.
//

import Foundation

class HourlyEmployeePass: ParkPass, Swipable {
    
    init(type: PassSubType, firstName: String?, lastName: String?,
         streetAddress: String?, city: String?,
         state: String?, zipcode: String?,
         dateOfBirth: Date?, socialSecurityNumber: String?) throws {
        do {
            try super.init(passType: type, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth, socialSecurityNumber: socialSecurityNumber)
            printPassGenerationStatus()
        } catch MissingInformationError.inSufficientData(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
    
}
