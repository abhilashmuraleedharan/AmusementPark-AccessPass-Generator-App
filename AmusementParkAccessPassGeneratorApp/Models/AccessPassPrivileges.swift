//
//  AccessPassPrivileges.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

/// Defines the different areas of the amusement park that needs an appropriate pass to get access.
enum ParkAccessArea: String {
    case amusementArea = "Amusement Area"
    case kitchenArea = "Kitchen Area"
    case rideControlArea = "Ride Control Area"
    case maintenanceArea = "Maintenance Area"
    case officeArea = "Office Area"
}

/// Defines the type of privileges a pass owner can have for rides in the amusement park.
enum RidePrivilege: String {
    case allRidesAccess = "All Rides"
    case skipAllRideLinesAccess = "Skip All Ride Lines"
}

/// Defines the type of discounts offered by the park to different pass owners.
enum ParkDiscount: String {
    case employeeDiscount = "15% discount on food and 25% discount on merchandise"
    case vipGuestDiscount = "10% discount on food and 20% discount on merchandise"
    case managerDiscount = "25% discount on food and 25% discount on merchandise"
    
    func getDiscountValues() -> (foodDiscount: Double, merchandiseDiscount: Double) {
        switch self {
        case .employeeDiscount: return (foodDiscount: 15.0, merchandiseDiscount: 25.0)
        case .vipGuestDiscount: return (foodDiscount: 10.0, merchandiseDiscount: 20.0)
        case .managerDiscount: return (foodDiscount: 25.0, merchandiseDiscount: 25.0)
        }
    }
}
