//
//  FormDataProvider.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 29/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

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
}
