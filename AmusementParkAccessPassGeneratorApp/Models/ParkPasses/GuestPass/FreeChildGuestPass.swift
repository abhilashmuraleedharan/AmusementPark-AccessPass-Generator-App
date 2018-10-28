//
//  FreeChildGuestPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class FreeChildGuestPass: ParkPass, MultiSwipeRejectable {
    var lastAccessTime: Date?
    init(firstName: String? = nil, lastName: String? = nil,
         streetAddress: String? = nil, city: String? = nil,
         state: String? = nil, zipcode: String? = nil,
         dateOfBirth: Date? = nil) {
        super.init(passType: .freeChildGuestPass, firstName: firstName,
                   lastName: lastName, streetAddress: streetAddress,
                   city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth)
    }
}

extension FreeChildGuestPass {
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool) {
        let result: String
        let isPositive: Bool
        
        if canSwipe() {
            if accessibleAreas.contains(checkpoint) {
                result = "Hi, VIP Guest Pass User. You have been granted access to \(checkpoint.rawValue)."
                isPositive = true
            } else {
                result = "Sorry, as a VIP Guest Pass user, you don't have access to \(checkpoint.rawValue)."
                isPositive = false
            }
            updateLastAccessTime()
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for parkDiscount: ParkDiscount) -> (result: String, isPositive: Bool) {
        let result: String
        let isPositive: Bool
        
        if canSwipe() {
            if  parkDiscounts.contains(parkDiscount){
                result = "Hi Free Child Guest Pass user, You are eligible for \(parkDiscount.rawValue)"
                isPositive = true
            } else {
                result = "Sorry, as a Free Child Guest Pass user, You are not eligible for \(parkDiscount.rawValue)"
                isPositive = false
            }
            updateLastAccessTime()
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool) {
        let result: String
        let isPositive: Bool
        
        if canSwipe() {
            if ridePrivileges.contains(ridePrivilege) {
                result = "Hi, Free Child Guest Pass user, You have \(ridePrivilege.rawValue) access."
                isPositive = true
            } else {
                result = "Sorry, as a Free Child Guest Pass user, you don't have \(ridePrivilege.rawValue) access."
                isPositive = false
            }
            updateLastAccessTime()
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
}
