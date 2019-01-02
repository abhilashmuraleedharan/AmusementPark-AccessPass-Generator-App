//
//  AccessPassPrivileges.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

/// Defines the different areas of the amusement park that requires an appropriate access pass to gain access.
enum AccessRequiredParkArea: String {
    case amusementArea = "Amusement Areas"
    case kitchenArea = "Kitchen Areas"
    case rideControlArea = "Ride Control Areas"
    case maintenanceArea = "Maintenance Areas"
    case officeArea = "Office Areas"
}

/// Defines the type of privileges a pass owner can have for the rides in the amusement park.
enum RidePrivilege: String {
    case allRidesAccess = "All Rides Access"
    case skipAllRideLinesAccess = "Skip All Ride Lines Access"
}

/// Defines the type of discounts offered by the park to different pass owners.
enum ParkDiscount: String {
    case employeeDiscount = "15% discount on food and 25% discount on merchandise"
    case vipGuestDiscount = "10% VIP discount on food and 20% VIP discount on merchandise"
    case managerDiscount = "25% discount on food and 25% discount on merchandise"
    case seasonPassGuestDiscount = "10% discount on food and 20% discount on merchandise"
    case seniorGuestDiscount = "10% discount on food and 10% discount on merchandise"
}

extension RidePrivilege {
    var description: String {
        switch self {
        case .allRidesAccess: return "Unlimited Rides"
        case .skipAllRideLinesAccess: return "Skip Ride Lines"
        }
    }
}

extension ParkDiscount {
    func getDiscountValues() -> (foodDiscount: Double, merchandiseDiscount: Double) {
        switch self {
        case .employeeDiscount: return (foodDiscount: 15.0, merchandiseDiscount: 25.0)
        case .vipGuestDiscount, .seasonPassGuestDiscount: return (foodDiscount: 10.0, merchandiseDiscount: 20.0)
        case .managerDiscount: return (foodDiscount: 25.0, merchandiseDiscount: 25.0)
        case .seniorGuestDiscount: return (foodDiscount: 10.0, merchandiseDiscount: 10.0)
        }
    }
    
    var foodDiscount: String {
        return String(self.getDiscountValues().foodDiscount)
    }
    
    var merchandiseDiscount: String {
        return String(self.getDiscountValues().merchandiseDiscount)
    }
}
