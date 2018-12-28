//
//  FreeChildGuestPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class FreeChildGuestPass: GuestPass {
    
    init(dateOfBirth: Date?, firstName: String? = nil, lastName: String? = nil,
         streetAddress: String? = nil, city: String? = nil,
         state: String? = nil, zipcode: String? = nil) throws {
        do {
            try super.init(passType: .freeChildGuestPass, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress,
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth, projectNumber: nil, vendorCompany: nil, dateOfVisit: nil)
            // Issue pass only if the entrant is under 5 years old.
            if !qualifiedAsChild() {
                throw PassEligibilityError.notChild(errorMessage: "Not a child under 5 years of age. Cannot issue Free Child Guest Pass")
            }
            displayPassInformation()
        } catch MissingInformationError.inSufficientData(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch PassEligibilityError.notChild(let error) {
            throw PassEligibilityError.notChild(errorMessage: error)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "Unknown Error. \(error.localizedDescription)")
        }
    }
}

extension FreeChildGuestPass {
    /// This method checks whether the entrant is under 5 years old to issue a Free Child Guest Pass
    /// Returns false if the entrant is older than 5 years old.
    func qualifiedAsChild() -> Bool {
        let maxAllowedChildDateOfBirth = Calendar.current.date(byAdding: .year, value: -5, to: Date())!
        if let dob = passOwner.dateOfBirth {
            return dob < maxAllowedChildDateOfBirth ? false : true
        } else { return false }
    }
}
