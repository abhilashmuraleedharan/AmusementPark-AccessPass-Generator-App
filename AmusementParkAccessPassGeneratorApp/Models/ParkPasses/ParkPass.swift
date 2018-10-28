//
//  ParkPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class ParkPass: AccessPass {
    var passOwner: ParkEntrant
    var passType: PassSubCategory
    var accessibleAreas: [ParkAccessArea]
    var ridePrivileges: [RidePrivilege]
    var parkDiscounts: [ParkDiscount]
    
    init(passType: PassSubCategory, firstName: String? = nil, lastName: String? = nil,
                     streetAddress: String? = nil, city:String? = nil, state: String? = nil,
                     zipcode: String? = nil, dateOfBirth: Date? = nil) {
        
        let entrant = ParkEntrant(firstName: firstName, lastName: lastName,
                                  streetAddress: streetAddress, city: city, state: state,
                                  zipcode: zipcode, dateOfBirth: dateOfBirth)
        self.passOwner = entrant
        self.passType = passType
        self.accessibleAreas = passType.accessibleParkAreas
        self.ridePrivileges = passType.ridePrivileges
        self.parkDiscounts = passType.parkDiscounts
    }
}




