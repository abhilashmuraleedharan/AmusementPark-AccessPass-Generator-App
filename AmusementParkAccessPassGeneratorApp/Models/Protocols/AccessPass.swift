//
//  AccessPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

protocol AccessPass {
    var passOwner: Entrant { get }
    var passType: PassSubType { get }
    var accessibleAreas: [AccessRequiredParkArea] { get }
    var ridePrivileges: [RidePrivilege] { get }
    var parkDiscount: ParkDiscount? { get set }
}

