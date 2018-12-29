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
    let passType: PassSubType
    let accessibleAreas: [AccessRequiredParkArea]
    let ridePrivileges: [RidePrivilege]
    var parkDiscount: ParkDiscount?
    
    init(passType: PassSubType, firstName: String?, lastName: String?,
         streetAddress: String?, city:String?, state: String?,
         zipcode: String?, dateOfBirth: Date?, projectNumber: String?, vendorCompany: String?, dateOfVisit: Date?, type: ManagerSubType?) throws {
        let entrant: ParkEntrant
        do {
            entrant = try ParkEntrant(associatedPassType: passType, firstName: firstName,
                                      lastName: lastName, streetAddress: streetAddress,
                                      city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth,
                                      projectNumber: projectNumber, vendorCompany: vendorCompany, dateOfVisit: dateOfVisit, type: type)
            self.passOwner = entrant
            self.passType = passType
            self.accessibleAreas = passType.accessibleParkAreas
            self.ridePrivileges = passType.ridePrivileges
            self.parkDiscount = passType.parkDiscount
            
        } catch MissingInformationError.noCity(let error){
            let errorDescription = error + " requires city information."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noDateOfBirth(let error) {
            let errorDescription = error + " requires date of birth information."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noFirstName(let error) {
            let errorDescription = error + " requires first name."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noLastName(let error) {
            let errorDescription = error + " requires last name."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noState(let error) {
            let errorDescription = error + " requires state information."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noStreetAddress(let error) {
            let errorDescription = error + " requires street address."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noZipcode(let error) {
            let errorDescription = error + " requires zipcode."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noDateOfVisit(let error) {
            let errorDescription = error + " requires date of visit information."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
}

extension ParkPass {
    
    func printPassGenerationStatus() {
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
        print("\nSuccessfully generated a new \(passType.rawValue) for \(entrantName).\n")
    }
}



