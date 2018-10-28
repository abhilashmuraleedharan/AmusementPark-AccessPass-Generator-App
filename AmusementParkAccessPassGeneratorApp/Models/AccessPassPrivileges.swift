//
//  AccessPassPrivileges.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
enum ParkAccessArea: String {
    case amusementArea = "Amusement Area"
    case kitchenArea = "Kitchen Area"
    case rideControlArea = "Ride Control Area"
    case maintenanceArea = "Maintenance Area"
    case officeArea = "Office Area"
}

enum RidePrivilege: String {
    case allRidesAccess = "All rides"
    case skipAllRideLinesAccess = "Skip all ride lines"
}

enum ParkDiscount {
    case foodDiscount(percentage: Double)
    case merchandiseDiscount(percentage: Double)
    
    var information: String {
        switch self {
        case .foodDiscount(let percentage):
            return "Food Discount of \(percentage) %"
        case .merchandiseDiscount(let percentage):
            return "Merchandise discount of \(percentage) %"
        }
    }
}
