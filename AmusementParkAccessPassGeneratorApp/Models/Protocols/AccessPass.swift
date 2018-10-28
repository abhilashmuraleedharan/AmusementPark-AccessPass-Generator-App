//
//  AccessPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
import Foundation

protocol AccessPass {
    var passOwner: ParkEntrant { get }
    var passType: PassSubCategory { get }
    var accessibleAreas: [ParkAccessArea] { get }
    var ridePrivileges: [RidePrivilege] { get }
    var parkDiscount: ParkDiscount? { get set }
}

