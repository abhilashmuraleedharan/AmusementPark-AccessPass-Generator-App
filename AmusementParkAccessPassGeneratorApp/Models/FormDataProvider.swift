//
//  FormDataProvider.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 29/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
import Foundation

/// Type to provide data for each field in the user form to generate pass
struct FormDataProvider {
    
    typealias CityStateZipcodeData = (city: String, state: String, zipcode: String)
    
    private let firstNamesCollection = ["Heather", "Kaylin", "Elise", "Bernice", "Maddison", "Rhea", "Yadira", "Akeem", "Emilio", "Torrance", "Freddy", "Willis", "Lisandro", "Lempi", "Hailey"]
    private let lastNamesCollection = ["Gorczany", "Abbott", "Paucek", "Kirlin", "Casper", "Schamberger", "Cruickshank", "Bergstrom", "Nitzsche", "Quitzon", "Halvorson", "Raynor", "Lakin", "Cummings", "Vandervort"]
    private let streetAddressesCollection = [
        "51512 Pouros Locks",
        "7570 Leffler",
        "560 Noah Rue Oliverborough",
        "52029 Perry Station Pacochaside",
        "63412 Dorian Stravenue New Jarod",
        "0542 Meghan Land New Toni",
        "9373 Samara East Ebony",
        "7814 Emery Prairie West Lottie",
        "7741 Otho Summit Onachester",
        "0465 Jude Avenue Lake Elaina"
    ]
    private let cityStateZipcodeCollection: [CityStateZipcodeData] = [
        (city: "Denver", state: "Colorado", zipcode: "80014"),
        (city: "Mumbai", state: "Maharashtra", zipcode: "230532"),
        (city: "Dallas", state: "Texas", zipcode: "75043"),
        (city: "Seattle", state: "Washington", zipcode: "98101"),
        (city: "Montreal", state: "Quebec", zipcode: "65591"),
        (city: "Bengaluru", state: "Karnataka", zipcode: "560045"),
        (city: "Boston", state: "Massachusetts", zipcode: "02111"),
        (city: "Detroit", state: "Michigan", zipcode: "48127"),
        (city: "Baltimore", state: "Maryland", zipcode: "21207"),
        (city: "Austin", state: "Texas", zipcode: "73301")
    ]
    
    /// List of projects to be displayed in project picker
    var projectPickerViewData = [String]()
    
    /// List of vendor companies to be displayed in company picker
    var companyPickerViewData = [String]()
    
    /// List of management tiers to be displayed in tier picker
    var managementTierData = [String]()
    
    init() {
        for project in ContractorPass.allCases {
            projectPickerViewData.append(project.rawValue)
        }
        for company in VendorCompanyPass.allCases {
            companyPickerViewData.append(company.rawValue.uppercased())
        }
        for tier in ManagementTier.allCases {
            managementTierData.append(tier.rawValue)
        }
    }
    
    var firstNameData: String {
        return firstNamesCollection.randomElement()!
    }
    var lastNameData: String {
        return lastNamesCollection.randomElement()!
    }
    var streetAddressData: String {
        return streetAddressesCollection.randomElement()!
    }
    var cityStateZipcodeData: CityStateZipcodeData {
        return cityStateZipcodeCollection.randomElement()!
    }
    
    let dateOfBirth = "01/01/1970"
    let ssn = "123-45-6789"
    
    var dateOfVisit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: Date())
    }
    
    var projectData: String {
        return projectPickerViewData.randomElement()!
    }
    
    var companyData: String {
        return companyPickerViewData.randomElement()!
    }
    
    var childDateOfBirthData: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: Calendar.current.date(byAdding: .year, value: -4, to: Date())!)
    }
    
    var seniorDateOfBirthData: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: Calendar.current.date(byAdding: .year, value: -60, to: Date())!)
    }
    
}
