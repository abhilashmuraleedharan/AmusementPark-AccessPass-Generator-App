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
enum PassSubType: String {
    case classicGuestPass = "Classic Guest Pass"
    case vipGuestPass = "VIP Guest Pass"
    case freeChildGuestPass = "Free Child Guest Pass"
    case hourlyEmployeeFoodServicePass = "Hourly Employee Food Service Pass"
    case hourlyEmployeeRideServicePass = "Hourly Employee Ride Service Pass"
    case hourlyEmployeeMaintenancePass = "Hourly Employee Maintenance Pass"
    case managerPass = "Manager Pass"
    case seasonGuestPass = "Season Guest Pass"
    case seniorGuestPass = "Senior Guest Pass"
    case project1001ContractEmployeePass = "Project 1001 Contract Employee Pass"
    case project1002ContractEmployeePass = "Project 1002 Contract Employee Pass"
    case project1003ContractEmployeePass = "Project 1003 Contract Employee Pass"
    case project2001ContractEmployeePass = "Project 2001 Contract Employee Pass"
    case project2002ContractEmployeePass = "Project 2002 Contract Employee Pass"
    case acmeCompanyVendorPass = "Acme Company Vendor Pass"
    case orkinCompanyVendorPass = "Orkin Company Vendor Pass"
    case fedexCompanyVendorPass = "Fedex Company Vendor Pass"
    case nwelectricalCompanyVendorPass = "NW Electrical Company Vendor Pass"
}

enum ManagementTier: String, CaseIterable {
    case senior = "senior"
    case general = "general"
    case shift = "shift"
}

enum VendorCompanyPass: String, CaseIterable {
    case acme = "acme"
    case fedex = "fedex"
    case orkin = "orkin"
    case nwelectrical = "nw electrical"
}

enum ContractorPass: String, CaseIterable {
    case project1001 = "1001"
    case project1002 = "1002"
    case project1003 = "1003"
    case project2001 = "2001"
    case project2002 = "2002"
}

extension VendorCompanyPass {
    var associatedPassType: PassSubType {
        switch self {
        case .acme: return PassSubType.acmeCompanyVendorPass
        case .fedex: return PassSubType.fedexCompanyVendorPass
        case .orkin: return PassSubType.orkinCompanyVendorPass
        case .nwelectrical: return PassSubType.nwelectricalCompanyVendorPass
        }
    }
}

extension ContractorPass {
    var associatedPassType: PassSubType {
        switch self {
        case .project1001: return PassSubType.project1001ContractEmployeePass
        case .project1002: return PassSubType.project1002ContractEmployeePass
        case .project1003: return PassSubType.project1003ContractEmployeePass
        case .project2001: return PassSubType.project2001ContractEmployeePass
        case .project2002: return PassSubType.project2002ContractEmployeePass
        }
    }
}

extension PassCategory {
    /// Based on the main pass type, this computed property returns its corresponding sub types
    var passSubTypeList: [PassSubType] {
        switch self {
        case .guest:
            return [PassSubType.classicGuestPass, PassSubType.vipGuestPass, PassSubType.freeChildGuestPass, PassSubType.seasonGuestPass, PassSubType.seniorGuestPass]
        case .employee:
            return [PassSubType.hourlyEmployeeFoodServicePass, PassSubType.hourlyEmployeeMaintenancePass, PassSubType.hourlyEmployeeRideServicePass]
        case .manager, .contractor, .vendor: return []
        }
    }
}

extension PassSubType {
    /// Based on the Pass sub-type, this computed property returns the collection of park areas accessible by that pass type.
    var accessibleParkAreas: [AccessRequiredParkArea] {
        switch self {
        case .classicGuestPass, .vipGuestPass, .freeChildGuestPass, .seasonGuestPass, .seniorGuestPass:
            return [AccessRequiredParkArea.amusementArea]
        case .hourlyEmployeeRideServicePass, .project1001ContractEmployeePass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.rideControlArea]
        case .hourlyEmployeeMaintenancePass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.maintenanceArea, AccessRequiredParkArea.kitchenArea, AccessRequiredParkArea.rideControlArea]
        case .hourlyEmployeeFoodServicePass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.kitchenArea]
        case .managerPass, .project1003ContractEmployeePass, .nwelectricalCompanyVendorPass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.kitchenArea, AccessRequiredParkArea.maintenanceArea,
                    AccessRequiredParkArea.officeArea, AccessRequiredParkArea.rideControlArea]
        case .project1002ContractEmployeePass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.rideControlArea, AccessRequiredParkArea.maintenanceArea]
        case .project2001ContractEmployeePass:
            return [AccessRequiredParkArea.officeArea]
        case .project2002ContractEmployeePass:
            return [AccessRequiredParkArea.kitchenArea, AccessRequiredParkArea.maintenanceArea]
        case .acmeCompanyVendorPass:
            return [AccessRequiredParkArea.kitchenArea]
        case .orkinCompanyVendorPass:
            return [AccessRequiredParkArea.amusementArea, AccessRequiredParkArea.kitchenArea, AccessRequiredParkArea.rideControlArea]
        case .fedexCompanyVendorPass:
            return [AccessRequiredParkArea.maintenanceArea, AccessRequiredParkArea.officeArea]
        }
    }
    
    /// Based on the Pass sub-type, this computed property returns the collection of park discounts available for that pass type.
    var parkDiscount: ParkDiscount? {
        switch self {
        case .vipGuestPass: return ParkDiscount.vipGuestDiscount
        case .hourlyEmployeeFoodServicePass,.hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass:
            return ParkDiscount.employeeDiscount
        case .managerPass: return ParkDiscount.managerDiscount
        case .seniorGuestPass: return ParkDiscount.seniorGuestDiscount
        case .seasonGuestPass: return ParkDiscount.seasonPassGuestDiscount
        default: return nil
        }
    }
    
    /// Based on the Pass sub-type, this computed property returns the collection of ride privileges available for that pass type.
    var ridePrivileges: [RidePrivilege] {
        switch self {
        case .vipGuestPass, .seniorGuestPass, .seasonGuestPass: return [RidePrivilege.allRidesAccess, RidePrivilege.skipAllRideLinesAccess]
        case .classicGuestPass, .freeChildGuestPass, .hourlyEmployeeFoodServicePass, .hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass, .managerPass: return [RidePrivilege.allRidesAccess]
        default: return []
        }
    }
    
    /// Based on the Pass sub-type, this computed property returns the menu button titles to be displayed in form
    var subMenuButtonTitle: String? {
        switch self {
        case .classicGuestPass: return "Classic"
        case .vipGuestPass: return "VIP"
        case .freeChildGuestPass: return "Free Child"
        case .seasonGuestPass: return "Season Pass"
        case .seniorGuestPass: return "Senior"
        case .hourlyEmployeeFoodServicePass: return "Hourly Food Service"
        case .hourlyEmployeeRideServicePass: return "Hourly Ride Service"
        case .hourlyEmployeeMaintenancePass: return "Hourly Maintenance"
        default: return nil
        }
    }
}
