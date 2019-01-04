//
//  ManagerPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class ManagerPass: AccessPass, Swipable {
    
    let passOwner: Entrant
    let passType: PassSubType
    let accessibleAreas: [AccessRequiredParkArea]
    let ridePrivileges: [RidePrivilege]
    var parkDiscount: ParkDiscount?
    
    init(firstName: String?, lastName: String?,
         streetAddress: String?, city:String?, state: String?,
         zipcode: String?, dateOfBirth: Date?, socialSecurityNumber: String?, tier: ManagementTier?) throws {
        let entrant: Entrant
        do {
            entrant = try ParkManager(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipcode: zipcode,
                                      dateOfBirth: dateOfBirth, socialSecurityNumber: socialSecurityNumber, tier: tier)
            self.passOwner = entrant
            self.passType = .managerPass
            self.accessibleAreas = passType.accessibleParkAreas
            self.ridePrivileges = passType.ridePrivileges
            self.parkDiscount = passType.parkDiscount
            
            printPassGenerationStatus()
        } catch MissingInformationError.noCity(let error){
            let errorDescription = error + " requires city information."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noDateOfBirth(let error) {
            let errorDescription = error + " requires date of birth information."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noSocialSecurityNumber(let error) {
            let errorDescription = error + " requires Social Security Number."
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
        } catch MissingInformationError.noManagementTier(let error) {
            let errorDescription = error + " requires management tier information."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
    
}

extension ManagerPass {
    
    func printPassGenerationStatus() {
        print("\nSuccessfully generated a new \(passType.rawValue) for \(passOwner.firstName!) \(passOwner.lastName!).\n")
    }
    
}
