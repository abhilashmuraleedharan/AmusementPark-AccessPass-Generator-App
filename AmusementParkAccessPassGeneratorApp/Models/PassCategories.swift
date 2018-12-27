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
    case contractor
    case vendor
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
    case seasonGuestPass = "Season Pass Guest"
    case seniorGuestPass = "Senior Guest Pass"
    case project1001ContractorPass = "Project 1001 Contractor Pass"
    case project1002ContractorPass = "Project 1002 Contractor Pass"
    case project1003ContractorPass = "Project 1003 Contractor Pass"
    case project2001ContractorPass = "Project 2001 Contractor Pass"
    case project2002ContractorPass = "Project 2002 Contractor Pass"
    case acmeCompanyVendorPass = "Acme Company Vendor Pass"
    case orikinCompanyVendorPass = "Orikin Company Vendor Pass"
    case fedexCompanyVendorPass = "Fedex Company Vendor Pass"
    case nwelectricalCompanyVendorPass = "NW Electrical Company Vendor Pass"
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
        case .contractor:
            return [PassSubCategory.project1001ContractorPass, PassSubCategory.project1002ContractorPass, PassSubCategory.project1003ContractorPass, PassSubCategory.project2001ContractorPass, PassSubCategory.project2002ContractorPass]
        case .vendor:
            return [PassSubCategory.acmeCompanyVendorPass, PassSubCategory.orikinCompanyVendorPass, PassSubCategory.fedexCompanyVendorPass, PassSubCategory.nwelectricalCompanyVendorPass]
        }
    }
}

extension PassSubCategory {
    /// Based on the Sub Category Pass type, this computed property returns the collection of park areas accessible by that pass type.
    var accessibleParkAreas: [AccessRequiredParkArea] {
        switch self {
        case .classicGuestPass, .vipGuestPass, .freeChildGuestPass, .seasonGuestPass, .seniorGuestPass:
            return [AccessRequiredParkArea.amusementArea]
        case .hourlyEmployeeRideServicePass, .project1001ContractorPass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.rideControlArea]
        case .hourlyEmployeeMaintenancePass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.maintenanceArea, AccessRequiredParkArea.kitchenArea, AccessRequiredParkArea.rideControlArea]
        case .hourlyEmployeeFoodServicePass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.kitchenArea]
        case .managerPass, .project1003ContractorPass, .nwelectricalCompanyVendorPass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.kitchenArea, AccessRequiredParkArea.maintenanceArea,
                    AccessRequiredParkArea.officeArea, AccessRequiredParkArea.rideControlArea]
        case .project1002ContractorPass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.rideControlArea, AccessRequiredParkArea.maintenanceArea]
        case .project2001ContractorPass:
            return [AccessRequiredParkArea.officeArea]
        case .project2002ContractorPass:
            return [AccessRequiredParkArea.kitchenArea, AccessRequiredParkArea.maintenanceArea]
        case .acmeCompanyVendorPass:
            return [AccessRequiredParkArea.kitchenArea]
        case .orikinCompanyVendorPass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.kitchenArea, AccessRequiredParkArea.rideControlArea]
        case .fedexCompanyVendorPass:
            return [AccessRequiredParkArea.maintenanceArea, AccessRequiredParkArea.officeArea]
        }
    }
    
    /// Based on the Sub Category Pass type, this computed property returns the collection of park discounts available for that pass type.
    var parkDiscount: ParkDiscount? {
        switch self {
        case .classicGuestPass, .freeChildGuestPass, .acmeCompanyVendorPass, .fedexCompanyVendorPass, .nwelectricalCompanyVendorPass, .orikinCompanyVendorPass,
             .project1001ContractorPass, .project1002ContractorPass, .project1003ContractorPass, .project2001ContractorPass, .project2002ContractorPass: return nil
        case .vipGuestPass: return ParkDiscount.vipGuestDiscount
        case .hourlyEmployeeFoodServicePass,.hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass:
            return ParkDiscount.employeeDiscount
        case .managerPass: return ParkDiscount.managerDiscount
        case .seniorGuestPass: return ParkDiscount.seniorGuestDiscount
        case .seasonGuestPass: return ParkDiscount.seasonPassGuestDiscount
        }
    }
    
    /// Based on the Sub Category Pass type, this computed property returns the collection of ride privileges available for that pass type.
    var ridePrivileges: [RidePrivilege] {
        switch self {
        case .vipGuestPass, .seniorGuestPass, .seasonGuestPass: return [RidePrivilege.allRidesAccess, RidePrivilege.skipAllRideLinesAccess]
        case .classicGuestPass, .freeChildGuestPass, .hourlyEmployeeFoodServicePass, .hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass, .managerPass: return [RidePrivilege.allRidesAccess]
        default: return []
        }
    }
}
