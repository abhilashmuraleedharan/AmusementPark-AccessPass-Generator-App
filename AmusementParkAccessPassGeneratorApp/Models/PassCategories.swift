//
//  PassCategories.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
enum PassCategory {
    case guest
    case employee
    case manager
}

enum PassSubCategory {
    case classicGuestPass
    case vipGuestPass
    case freeChildGuestPass
    case hourlyEmployeeFoodServicePass
    case hourlyEmployeeRideServicePass
    case hourlyEmployeeMaintenancePass
    case managerPass
}

extension PassCategory {
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
    var accessibleParkAreas: [ParkAccessArea] {
        switch self {
        case .classicGuestPass, .vipGuestPass, .freeChildGuestPass:
            return [ParkAccessArea.amusementArea]
        case .hourlyEmployeeRideServicePass:
            return [ParkAccessArea.amusementArea, ParkAccessArea.rideControlArea]
        case .hourlyEmployeeMaintenancePass:
            return [ParkAccessArea.amusementArea, ParkAccessArea.maintenanceArea]
        case .hourlyEmployeeFoodServicePass:
            return [ParkAccessArea.amusementArea, ParkAccessArea.kitchenArea]
        case .managerPass:
            return [ParkAccessArea.amusementArea, ParkAccessArea.kitchenArea, ParkAccessArea.maintenanceArea,
                    ParkAccessArea.officeArea, ParkAccessArea.rideControlArea]
        }
    }
    
    var parkDiscounts: [ParkDiscount] {
        switch self {
        case .classicGuestPass, .freeChildGuestPass: return []
        case .vipGuestPass: return [ParkDiscount.foodDiscount(percentage: 10.0), ParkDiscount.merchandiseDiscount(percentage: 20.0)]
        case .hourlyEmployeeFoodServicePass,.hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass:
            return [ParkDiscount.foodDiscount(percentage: 15.0), ParkDiscount.merchandiseDiscount(percentage: 25.0)]
        case .managerPass: return [ParkDiscount.foodDiscount(percentage: 25.0), ParkDiscount.merchandiseDiscount(percentage: 25.0)]
        }
    }
    
    var ridePrivileges: [RidePrivilege] {
        switch self {
        case .vipGuestPass: return [RidePrivilege.allRidesAccess, RidePrivilege.skipAllRideLinesAccess]
        default: return [RidePrivilege.allRidesAccess]
        }
    }
}
