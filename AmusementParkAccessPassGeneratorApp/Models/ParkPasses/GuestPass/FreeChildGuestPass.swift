//
//  FreeChildGuestPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class FreeChildGuestPass: GuestPass {
    
    var didShowBirthDayGreeting = false
    
    init(firstName: String? = nil, lastName: String? = nil,
         streetAddress: String? = nil, city: String? = nil,
         state: String? = nil, zipcode: String? = nil,
         dateOfBirth: Date? = nil) throws {
        do {
            try super.init(passType: .freeChildGuestPass, firstName: firstName,
                           lastName: lastName, streetAddress: streetAddress,
                           city: city, state: state, zipcode: zipcode, dateOfBirth: dateOfBirth)
            if !qualifiedAsChild() {
                throw AgeDependentError.notChild(error: "Not a child under 5 years of age. Cannot issue Free Child Guest Pass")
            } 
        } catch MissingInformationError.incompleteData(let error) {
            throw MissingInformationError.incompleteData(error: error)
        } catch let error {
            throw MissingInformationError.incompleteData(error: "Unknown Error. \(error.localizedDescription)")
        }
    }
    
}

extension FreeChildGuestPass {
    
    func qualifiedAsChild() -> Bool {
        let maxAllowedChildDateOfBirth = Calendar.current.date(byAdding: .year, value: -5, to: Date())!;
        let dob = passOwner.dateOfBirth!
        return dob < maxAllowedChildDateOfBirth ? false : true
    }
    
}

extension FreeChildGuestPass: Swipable {
    
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool, bdayGreeting: String?) {
        let result: String
        let isPositive: Bool
        var bdayGreeting: String?
        
        if isTodayBirthday() {
            if let firstname = passOwner.firstName {
                bdayGreeting = "Many Many Happy Returns Of The Day, \(firstname)"
            }
        }
        
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
        if didShowBirthDayGreeting {
            return (result: result, isPositive: isPositive, nil)
        } else {
            didShowBirthDayGreeting = true
            return (result: result, isPositive: isPositive, bdayGreeting: bdayGreeting)
        }
    }
    
    func swipe(for parkDiscount: ParkDiscount?) -> (result: String, isPositive: Bool, bdayGreeting: String?) {
        let result: String
        let isPositive: Bool
        var bdayGreeting: String?
        
        if isTodayBirthday() {
            if let firstname = passOwner.firstName {
                bdayGreeting = "Many Many Happy Returns Of The Day, \(firstname)"
            }
        }
        
        if canSwipe() {
            guard let discount = parkDiscount else {
                result = "Sorry, as a Free Child Guest Pass user, You are not eligible for any discount"
                isPositive = false
                if didShowBirthDayGreeting {
                    return (result: result, isPositive: isPositive, nil)
                } else {
                    didShowBirthDayGreeting = true
                    return (result: result, isPositive: isPositive, bdayGreeting: bdayGreeting)
                }
            }
            result = "Hi, Free Child Pass user, You are eligible for \(discount.rawValue)"
            isPositive = true
            updateLastAccessTime()
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        if didShowBirthDayGreeting {
            return (result: result, isPositive: isPositive, nil)
        } else {
            didShowBirthDayGreeting = true
            return (result: result, isPositive: isPositive, bdayGreeting: bdayGreeting)
        }
    }
    
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool, bdayGreeting: String?) {
        let result: String
        let isPositive: Bool
        var bdayGreeting: String?
        
        if isTodayBirthday() {
            if let firstname = passOwner.firstName {
                bdayGreeting = "Many Many Happy Returns Of The Day, \(firstname)"
            }
        }
        
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
        if didShowBirthDayGreeting {
            return (result: result, isPositive: isPositive, nil)
        } else {
            didShowBirthDayGreeting = true
            return (result: result, isPositive: isPositive, bdayGreeting: bdayGreeting)
        }
    }
    
}
