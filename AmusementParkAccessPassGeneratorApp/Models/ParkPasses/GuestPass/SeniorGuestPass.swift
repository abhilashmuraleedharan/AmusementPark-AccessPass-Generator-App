//
//  SeniorGuestPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 29/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class SeniorGuestPass: GuestPass {
    
    let minimumAgeForSeniorGuest = 60
    
    init(dateOfBirth: Date?, firstName: String?, lastName: String?,
         streetAddress: String? = nil, city: String? = nil,
         state: String? = nil, zipcode: String? = nil) throws {
        do {
            try super.init(passType: .seniorGuestPass, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress,
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth, projectNumber: nil, vendorCompany: nil, dateOfVisit: nil, tier: nil)
            // Issue pass only if the entrant is under child age limit.
            if !isQualifiedAsSeniorGuest() {
                throw PassEligibilityError.notSenior(errorMessage: "Not a guest above \(minimumAgeForSeniorGuest) years of age. Cannot issue Senior Guest Pass")
            }
            printPassGenerationStatus()
        } catch MissingInformationError.inSufficientData(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch PassEligibilityError.notSenior(let error) {
            throw PassEligibilityError.notSenior(errorMessage: error)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
}

extension SeniorGuestPass {
    /// This method checks whether the guest qualifies as a senior to issue a Senior Guest Pass
    /// Returns false if the guest is not older than the minimum age set for senior guest.
    private func isQualifiedAsSeniorGuest() -> Bool {
        let startingDobForSenior = Calendar.current.date(byAdding: .year, value: -minimumAgeForSeniorGuest, to: Date())!
        if let dob = passOwner.dateOfBirth {
            return dob <= startingDobForSenior
        } else { return false }
    }
}
