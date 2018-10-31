//
//  HourlyEmployeeMaintenancePass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class HourlyEmployeeMaintenancePass: ParkPass, Swipable {
    
    init(firstName: String?, lastName: String?,
         streetAddress: String?, city: String?,
         state: String?, zipcode: String?,
         dateOfBirth: Date?) throws {
        do {
            try super.init(passType: .hourlyEmployeeMaintenancePass, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress,
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth)
            displayPassInformation()
        } catch MissingInformationError.incompleteData(let error) {
            throw MissingInformationError.incompleteData(error: error)
        } catch let error {
            throw MissingInformationError.incompleteData(error: "Unknown Error. \(error.localizedDescription)")
        }
    }
}
