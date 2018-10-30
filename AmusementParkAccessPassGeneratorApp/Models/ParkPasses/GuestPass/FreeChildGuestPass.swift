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
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth)
            if !qualifiedAsChild() {
                throw PassQualificationError.notChild(error: "Not a child under 5 years of age. Cannot issue Free Child Guest Pass")
            }
            displayPassInformation()
        } catch MissingInformationError.incompleteData(let error) {
            throw MissingInformationError.incompleteData(error: error)
        } catch let error {
            throw MissingInformationError.incompleteData(error: "Unknown Error. \(error.localizedDescription)")
        }
    }
}

extension FreeChildGuestPass {
    
    func qualifiedAsChild() -> Bool {
        let maxAllowedChildDateOfBirth = Calendar.current.date(byAdding: .year, value: -5, to: Date())!;
        let dob = passOwner.dateOfBirth!
        return dob < maxAllowedChildDateOfBirth ? false : true
    }
}
