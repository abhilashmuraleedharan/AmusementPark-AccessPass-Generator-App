//
//  PassCategories.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

/// Main Categories of the Amusement Park Pass
enum PassCategory {
    case guest
    case employee
    case manager
}

/// Sub Category types of the Amusement Park Pass
enum PassSubCategory: String {
    case classicGuestPass = "Classic Guest Pass"
    case vipGuestPass = "VIP Guest Pass"
    case freeChildGuestPass = "Free Child Guest Pass"
    case hourlyEmployeeFoodServicePass = "Hourly Employee Food Service Pass"
    case hourlyEmployeeRideServicePass = "Hourly Employee Ride Service Pass"
    case hourlyEmployeeMaintenancePass = "Hourly Employee Maintenance Pass"
    case managerPass = "Manager Pass"
}

extension PassCategory {
    /// Based on the main pass type, this computed property returns its corresponding sub types
    var passSubCategoryList: [PassSubCategory] {
        switch self {
        case .guest:
            return [PassSubCategory.classicGuestPass, PassSubCategory.vipGuestPass, PassSubCategory.freeChildGuestPass]
        case .employee:
            return [PassSubCategory.hourlyEmployeeFoodServicePass, PassSubCategory.hourlyEmployeeMaintenancePass, PassSubCategory.hourlyEmployeeRideServicePass]
        case .manager: return []
        }
    }
}

extension PassSubCategory {
    /// Based on the Sub Category Pass type, this computed property returns the collection of park areas accessible by that pass type.
    var accessibleParkAreas: [ParkAccessArea] {
        switch self {
        case .classicGuestPass, .vipGuestPass, .freeChildGuestPass:
            return [ParkAccessArea.amusementArea]
        case .hourlyEmployeeRideServicePass:
            return [ParkAccessArea.amusementArea, ParkAccessArea.rideControlArea]
        case .hourlyEmployeeMaintenancePass:
            return [ParkAccessArea.amusementArea, ParkAccessArea.maintenanceArea, ParkAccessArea.kitchenArea, ParkAccessArea.rideControlArea]
        case .hourlyEmployeeFoodServicePass:
            return [ParkAccessArea.amusementArea, ParkAccessArea.kitchenArea]
        case .managerPass:
            return [ParkAccessArea.amusementArea, ParkAccessArea.kitchenArea, ParkAccessArea.maintenanceArea,
                    ParkAccessArea.officeArea, ParkAccessArea.rideControlArea]
        }
    }
    
    /// Based on the Sub Category Pass type, this computed property returns the collection of park discounts available for that pass type.
    var parkDiscount: ParkDiscount? {
        switch self {
        case .classicGuestPass, .freeChildGuestPass: return nil
        case .vipGuestPass: return ParkDiscount.vipGuestDiscount
        case .hourlyEmployeeFoodServicePass,.hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass:
            return ParkDiscount.employeeDiscount
        case .managerPass: return ParkDiscount.managerDiscount
        }
    }
    
    /// Based on the Sub Category Pass type, this computed property returns the collection of ride privileges available for that pass type.
    var ridePrivileges: [RidePrivilege] {
        switch self {
        case .vipGuestPass: return [RidePrivilege.allRidesAccess, RidePrivilege.skipAllRideLinesAccess]
        default: return [RidePrivilege.allRidesAccess]
        }
    }
}
