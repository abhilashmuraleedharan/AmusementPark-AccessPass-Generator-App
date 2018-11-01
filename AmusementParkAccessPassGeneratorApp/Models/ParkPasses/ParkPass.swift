//
//  ParkPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class ParkPass: AccessPass {
    let passOwner: ParkEntrant
    let passType: PassSubCategory
    let accessibleAreas: [ParkAccessArea]
    let ridePrivileges: [RidePrivilege]
    var parkDiscount: ParkDiscount?
    
    init(passType: PassSubCategory, firstName: String?, lastName: String?,
                     streetAddress: String?, city:String?, state: String?,
                     zipcode: String?, dateOfBirth: Date?) throws {
        let entrant: ParkEntrant
        do {
            entrant = try ParkEntrant(selectedPassType: passType, firstName: firstName,
                                      lastName: lastName, streetAddress: streetAddress,
                                      city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth)
            self.passOwner = entrant
            self.passType = passType
            self.accessibleAreas = passType.accessibleParkAreas
            self.ridePrivileges = passType.ridePrivileges
            self.parkDiscount = passType.parkDiscount
            
        } catch MissingInformationError.missingCity(let error){
            let errorDescription = error + " requires city information."
            throw MissingInformationError.incompleteData(error: errorDescription)
        } catch MissingInformationError.missingDateOfBirth(let error) {
            let errorDescription = error + " requires date of birth information."
            throw MissingInformationError.incompleteData(error: errorDescription)
        } catch MissingInformationError.missingFirstName(let error) {
            let errorDescription = error + " requires first name."
            throw MissingInformationError.incompleteData(error: errorDescription)
        } catch MissingInformationError.missingLastName(let error) {
            let errorDescription = error + " requires last name."
            throw MissingInformationError.incompleteData(error: errorDescription)
        } catch MissingInformationError.missingState(let error) {
            let errorDescription = error + " requires state information."
            throw MissingInformationError.incompleteData(error: errorDescription)
        } catch MissingInformationError.missingStreetAddress(let error) {
            let errorDescription = error + " requires street address."
            throw MissingInformationError.incompleteData(error: errorDescription)
        } catch MissingInformationError.missingZipcode(let error) {
            let errorDescription = error + " requires zipcode."
            throw MissingInformationError.incompleteData(error: errorDescription)
        } catch let error {
            let errorDescription = "Unknown Error. \(error.localizedDescription)"
            throw MissingInformationError.incompleteData(error: errorDescription)
        }
    }
}

extension ParkPass {
    
    func displayPassInformation() {
        var entrantName = ""
        
        if let firstName = passOwner.firstName, let lastName = passOwner.lastName {
            entrantName = "\(firstName) \(lastName)"
        } else {
            if let firstName = passOwner.firstName {
                entrantName = "\(firstName)"
            } else {
                if let lastName = passOwner.lastName {
                    entrantName = "\(lastName)"
                } else {
                    entrantName = "Anonymous Entrant"
                }
            }
        }
        print("\nSuccessfully created a new \(passType.rawValue) for \(entrantName).\n")
    }
}



