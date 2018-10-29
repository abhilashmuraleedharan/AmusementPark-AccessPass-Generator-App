//
//  AccessPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

protocol AccessPass {
    var passOwner: ParkEntrant { get }
    var passType: PassSubCategory { get }
    var accessibleAreas: [ParkAccessArea] { get }
    var ridePrivileges: [RidePrivilege] { get }
    var parkDiscount: ParkDiscount? { get set }
}

