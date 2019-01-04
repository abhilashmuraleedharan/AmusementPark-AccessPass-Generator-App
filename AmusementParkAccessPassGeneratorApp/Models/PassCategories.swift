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
    case senior = "Senior Manager"
    case general = "General Manager"
    case shift = "Shift Manager"
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
    /// Based on the vendor company pass type, this computed property returns its corresponding pass subtype
    var associatedPassType: PassSubType {
        switch self {
        case .acme: return .acmeCompanyVendorPass
        case .fedex: return .fedexCompanyVendorPass
        case .orkin: return .orkinCompanyVendorPass
        case .nwelectrical: return .nwelectricalCompanyVendorPass
        }
    }
}

extension ContractorPass {
    /// Based on the contractor pass type, this computed property returns its corresponding pass subtype
    var associatedPassType: PassSubType {
        switch self {
        case .project1001: return .project1001ContractEmployeePass
        case .project1002: return .project1002ContractEmployeePass
        case .project1003: return .project1003ContractEmployeePass
        case .project2001: return .project2001ContractEmployeePass
        case .project2002: return .project2002ContractEmployeePass
        }
    }
}

extension PassCategory {
    /// Based on the main pass type, this computed property returns its corresponding sub types
    var passSubTypeList: [PassSubType] {
        switch self {
        case .guest:
            return [.classicGuestPass, .vipGuestPass, .freeChildGuestPass, .seasonGuestPass, .seniorGuestPass]
        case .employee:
            return [.hourlyEmployeeFoodServicePass, .hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass]
        case .manager, .contractor, .vendor: return []
        }
    }
}

extension PassSubType {
    /// Based on the Pass sub-type, this computed property returns the collection of park areas accessible by that pass type.
    var accessibleParkAreas: [AccessRequiredParkArea] {
        switch self {
        case .classicGuestPass, .vipGuestPass, .freeChildGuestPass, .seasonGuestPass, .seniorGuestPass:
            return [.amusementArea]
        case .hourlyEmployeeRideServicePass, .project1001ContractEmployeePass:
            return [.amusementArea, .rideControlArea]
        case .hourlyEmployeeMaintenancePass:
            return [.amusementArea, .maintenanceArea, .kitchenArea, .rideControlArea]
        case .hourlyEmployeeFoodServicePass:
            return [.amusementArea, .kitchenArea]
        case .managerPass, .project1003ContractEmployeePass, .nwelectricalCompanyVendorPass:
            return [.amusementArea, .kitchenArea, .maintenanceArea, .officeArea, .rideControlArea]
        case .project1002ContractEmployeePass:
            return [.amusementArea, .rideControlArea, .maintenanceArea]
        case .project2001ContractEmployeePass:
            return [.officeArea]
        case .project2002ContractEmployeePass:
            return [.kitchenArea, .maintenanceArea]
        case .acmeCompanyVendorPass:
            return [.kitchenArea]
        case .orkinCompanyVendorPass:
            return [.amusementArea, .kitchenArea, .rideControlArea]
        case .fedexCompanyVendorPass:
            return [.maintenanceArea, .officeArea]
        }
    }
    
    /// Based on the Pass sub-type, this computed property returns the collection of park discounts available for that pass type.
    var parkDiscount: ParkDiscount? {
        switch self {
        case .vipGuestPass: return .vipGuestDiscount
        case .hourlyEmployeeFoodServicePass,.hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass: return .employeeDiscount
        case .managerPass: return .managerDiscount
        case .seniorGuestPass: return .seniorGuestDiscount
        case .seasonGuestPass: return .seasonPassGuestDiscount
        default: return nil
        }
    }
    
    /// Based on the Pass sub-type, this computed property returns the collection of ride privileges available for that pass type.
    var ridePrivileges: [RidePrivilege] {
        switch self {
        case .vipGuestPass, .seniorGuestPass, .seasonGuestPass: return [.allRidesAccess, .skipAllRideLinesAccess]
        case .classicGuestPass, .freeChildGuestPass, .hourlyEmployeeFoodServicePass, .hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass, .managerPass:
            return [.allRidesAccess]
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
