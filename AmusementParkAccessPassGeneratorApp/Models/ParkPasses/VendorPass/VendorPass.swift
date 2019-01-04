//
//  VendorPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 29/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class VendorPass: AccessPass, Swipable {
    
    let passOwner: Entrant
    let passType: PassSubType
    let accessibleAreas: [AccessRequiredParkArea]
    let ridePrivileges: [RidePrivilege]
    var parkDiscount: ParkDiscount?
    
    init(firstName: String?, lastName: String?,
         streetAddress: String?, city:String?, state: String?,
         zipcode: String?, dateOfBirth: Date?, socialSecurityNumber: String?, vendorCompany: String?, dateOfVisit: Date?) throws {
        let entrant: Entrant
        do {
            guard let company = vendorCompany else {
                throw MissingInformationError.noVendorCompany(errorMessage: "Vendor Pass requires company information.")
            }
            guard let name = VendorCompanyPass(rawValue: company.lowercased()) else {
                throw ValidationError.invalidVendorCompany(errorMessage: "Company not recognized. Vendor pass requires a valid company name.")
            }
            entrant = try ParkVendor(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipcode: zipcode,
                                     dateOfBirth: dateOfBirth, vendorCompany: vendorCompany, dateOfVisit: dateOfVisit, socialSecurityNumber: socialSecurityNumber)
            self.passOwner = entrant
            self.passType = name.associatedPassType
            self.accessibleAreas = passType.accessibleParkAreas
            self.ridePrivileges = passType.ridePrivileges
            self.parkDiscount = passType.parkDiscount
            
            printPassGenerationStatus()
        } catch MissingInformationError.noDateOfBirth(let error) {
            let errorDescription = error + " requires date of birth information."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noFirstName(let error) {
            let errorDescription = error + " requires first name."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noLastName(let error) {
            let errorDescription = error + " requires last name."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noDateOfVisit(let error) {
            let errorDescription = error + " requires date of visit information."
            throw MissingInformationError.inSufficientData(errorMessage: errorDescription)
        } catch MissingInformationError.noVendorCompany(let error) {
            throw MissingInformationError.noVendorCompany(errorMessage: error)
        } catch ValidationError.invalidVendorCompany(let error) {
            throw ValidationError.invalidVendorCompany(errorMessage: error)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
    
}

extension VendorPass {
    
    func printPassGenerationStatus() {
        print("\nSuccessfully generated a new \(passType.rawValue) for \(passOwner.firstName!) \(passOwner.lastName!).\n")
    }
    
}
