//
//  ClassicGuestPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class ClassicGuestPass: GuestPass {
    
    init(firstName: String? = nil, lastName: String? = nil,
         streetAddress: String? = nil, city: String? = nil,
         state: String? = nil, zipcode: String? = nil,
         dateOfBirth: Date? = nil) throws {
        do {
             try super.init(passType: .classicGuestPass, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress,
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth)
        } catch MissingInformationError.incompleteData(let error) {
            throw MissingInformationError.incompleteData(error: error)
        } catch let error {
            throw MissingInformationError.incompleteData(error: "Unknown Error. \(error.localizedDescription)")
        }
    }
}

extension ClassicGuestPass: Swipable {
    
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool) {
        let result: String
        let isPositive: Bool
        
        if canSwipe() {
            if accessibleAreas.contains(checkpoint) {
                result = "Hi, Classic Guest Pass User. You have been granted access to \(checkpoint.rawValue)."
                isPositive = true
                updateLastAccessTime()
            } else {
                result = "Sorry, as a Classic Guest Pass user, you don't have access to \(checkpoint.rawValue)."
                isPositive = false
            }
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for parkDiscount: ParkDiscount?) -> (result: String, isPositive: Bool) {
        let result: String
        let isPositive: Bool
        
        if canSwipe() {
            guard let discount = parkDiscount else {
               result = "Sorry, as a Classic Guest Pass user, You are not eligible for any discount"
               isPositive = false
               return (result: result, isPositive: isPositive)
            }
            result = "Hi, Classic Guest Pass user, You are eligible for \(discount.rawValue)"
            isPositive = true
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
                result = "Hi Classic Guest Pass user, You have \(ridePrivilege.rawValue) access."
                isPositive = true
                updateLastAccessTime()
            } else {
                result = "Sorry, as a Classic Guest Pass user, you don't have \(ridePrivilege.rawValue) access."
                isPositive = false
            }
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
}
