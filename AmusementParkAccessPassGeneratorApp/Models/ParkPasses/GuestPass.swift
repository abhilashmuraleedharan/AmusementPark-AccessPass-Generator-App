//
//  GuestPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class GuestPass: ParkPass {
    
    /// To store the last time the pass was swiped successfully.
    var lastAccessTime: Date?
    
    /// Contains the custom message that needs to be present in the alert message displayed to the entrant while swiping
    /// twice at the same ride within a span of 5 seconds.
    let unAuthorizedSecondSwipeAlertMsg = "Unauthorized swipe detected. This pass allows ONLY 1 person to a ride area at a time!"
    
    /// Method to update the last successful access time of this pass.
    func updateLastAccessTime() {
        lastAccessTime = Date()
    }
    
    /// Method to check whether an entrant is eligible to swipe at a ride.
    /// This method returns false if this is the second swipe made by the entrant
    /// within 5 seconds. This is to prevent someone from sneaking in a second person
    /// to a ride at a time.
    func canSwipe() -> Bool {
        let currentTime = Date()
        let currentTimeInSeconds = currentTime.timeIntervalSince1970
        if let lastAccessTime = lastAccessTime {
            let lastAccessTimeInSeconds = lastAccessTime.timeIntervalSince1970
            let timeDifference = Int(currentTimeInSeconds - lastAccessTimeInSeconds)
            return timeDifference > 5 ? true : false
        } else {
            // This is entrant's first swipe at that ride. Allow to swipe.
            return true
        }
    }
}

extension GuestPass: Swipable {
    
    // Customizing the Swipable protocol's method that handles the swipe action at a ride area for GuestPass.
    // This customization prevents a guest from swiping into a ride successively within 5 seconds.
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        // To add a custom b'day greeting message if swiped on b'day.
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
            result = unAuthorizedSecondSwipeAlertMsg
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
}
