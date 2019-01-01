//
//  HourlyEmployeeFoodServicesPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class HourlyEmployeeFoodServicesPass: ParkPass, Swipable {
    
    init(firstName: String?, lastName: String?,
         streetAddress: String?, city: String?,
         state: String?, zipcode: String?,
         dateOfBirth: Date?) throws {
        do {
            try super.init(passType: .hourlyEmployeeFoodServicePass, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress,
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth, projectNumber: nil, vendorCompany: nil, dateOfVisit: nil, tier: nil)
            printPassGenerationStatus()
        } catch MissingInformationError.inSufficientData(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
}
