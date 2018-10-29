//
//  GuestPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class GuestPass: ParkPass {
    var lastAccessTime: Date?
    
    func updateLastAccessTime() {
        lastAccessTime = Date()
    }
    
    func canSwipe() -> Bool {
        let currentTime = Date()
        let currentTimeInSeconds = currentTime.timeIntervalSince1970
        if let lastAccessTime = lastAccessTime {
            let lastAccessTimeInSeconds = lastAccessTime.timeIntervalSince1970
            let timeDifference = Int(currentTimeInSeconds - lastAccessTimeInSeconds)
            return timeDifference > 5 ? true : false
        } else {
            return true
        }
    }
}

extension GuestPass: Swipable {
    
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if canSwipe() {
            if accessibleAreas.contains(checkpoint) {
                result += "You are a \(passType.rawValue) User. You have access to \(checkpoint.rawValue)."
                isPositive = true
                updateLastAccessTime()
            } else {
                result += "Sorry, you're a \(passType.rawValue) User. You don't have access to \(checkpoint.rawValue)."
                isPositive = false
            }
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for parkDiscount: ParkDiscount?) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if canSwipe() {
            guard let discount = parkDiscount else {
                result += "Sorry, you're a \(passType.rawValue) User. You are not eligible for park discounts."
                isPositive = false
                return (result: result, isPositive: isPositive)
            }
            result += "You are a \(passType.rawValue) User. You are eligible to have \(discount.rawValue)."
            isPositive = true
            updateLastAccessTime()
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if canSwipe() {
            if ridePrivileges.contains(ridePrivilege) {
                result += "You are a \(passType.rawValue) User, You have \(ridePrivilege.rawValue) access."
                isPositive = true
                updateLastAccessTime()
            } else {
                result += "Sorry, you're a \(passType.rawValue) User. You don't have \(ridePrivilege.rawValue) access."
                isPositive = false
            }
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
}
