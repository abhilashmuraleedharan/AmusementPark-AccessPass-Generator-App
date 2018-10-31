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
    
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if canSwipe() {
            if ridePrivileges.contains(ridePrivilege) {
                result += "You have \(ridePrivilege.rawValue) access."
                isPositive = true
                updateLastAccessTime()
            } else {
                result += "Sorry, You don't have \(ridePrivilege.rawValue) access."
                isPositive = false
            }
        } else {
            result = UNAUTHORIZED_SWIPE_MSG
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
}
