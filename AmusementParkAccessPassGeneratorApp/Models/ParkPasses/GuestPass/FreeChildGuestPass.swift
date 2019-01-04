//
//  FreeChildGuestPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class FreeChildGuestPass: GuestPass {
    
    let childAgeLimit = 5
    
    init(dateOfBirth: Date?, firstName: String? = nil, lastName: String? = nil,
         streetAddress: String? = nil, city: String? = nil,
         state: String? = nil, zipcode: String? = nil, socialSecurityNumber: String? = nil) throws {
        do {
            try super.init(passType: .freeChildGuestPass, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth, socialSecurityNumber: socialSecurityNumber)
            // Issue pass only if the entrant is under child age limit.
            if !isQualifiedAsChild() {
                throw PassEligibilityError.notChild(errorMessage: "Not a child under \(childAgeLimit) years of age. Cannot issue Free Child Guest Pass")
            }
            printPassGenerationStatus()
        } catch MissingInformationError.inSufficientData(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch PassEligibilityError.notChild(let error) {
            throw PassEligibilityError.notChild(errorMessage: error)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
    
}

extension FreeChildGuestPass {
    /// This method checks whether the entrant's age is under child age limit to issue a Free Child Guest Pass
    /// Returns false if the entrant is older than the child age limit.
    private func isQualifiedAsChild() -> Bool {
        let dobLimitForChild = Calendar.current.date(byAdding: .year, value: -childAgeLimit, to: Date())!
        if let dob = passOwner.dateOfBirth {
            return dob < dobLimitForChild ? false : true
        } else { return false }
    }
}
