//
//  VendorPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 29/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class VendorPass: ParkPass, Swipable {
    
    private let companyPassTypeDictionary: [String: PassSubType] = [
        "Acme": .acmeCompanyVendorPass,
        "Orkin": .orkinCompanyVendorPass,
        "Fedex": .fedexCompanyVendorPass,
        "NW Electrical": .nwelectricalCompanyVendorPass
    ]
    
    init(firstName: String?, lastName: String?, vendorCompany: String?, dateOfBirth: Date?, dateOfVisit: Date?,
         streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipcode: String? = nil) throws {
        do {
            guard let company = vendorCompany else {
                throw MissingInformationError.noVendorCompany(errorMessage: "Vendor Pass requires company information.")
            }
            guard let passType = companyPassTypeDictionary[company] else {
                throw ValidationError.invalidVendorCompany(errorMessage: "Company not recognized. Vendor pass requires a valid company name.")
            }
            try super.init(passType: passType, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress,
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth, projectNumber: nil, vendorCompany: vendorCompany, dateOfVisit: dateOfVisit, tier: nil)
            printPassGenerationStatus()
        } catch MissingInformationError.inSufficientData(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch MissingInformationError.noVendorCompany(let error) {
            throw MissingInformationError.inSufficientData(errorMessage: error)
        } catch ValidationError.invalidVendorCompany(let error) {
            throw ValidationError.invalidVendorCompany(errorMessage: error)
        } catch let error {
            throw MissingInformationError.inSufficientData(errorMessage: "\(error.localizedDescription)")
        }
    }
}
