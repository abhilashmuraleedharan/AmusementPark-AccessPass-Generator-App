//
//  Swipable.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
import  Foundation

protocol Swipable: class, AccessPass{
    
    /// Method that handles the swipe action of an entrant at any access areas within the park.
    /// Returns a tuple containing the swipe result message and swipe status.
    /// - Parameters:
    ///     - at: Any AccessRequiredParkArea
    func swipe(at checkpoint: AccessRequiredParkArea) -> (result: String, isPositive: Bool)
    
    /// Method that handles the swipe action of an entrant to avail any discounts at eateries and shops inside park.
    /// Returns a tuple containing the swipe result message and swipe status.
    /// - Parameters:
    ///     - for: ParkDiscount
    func swipe(for parkDiscount: ParkDiscount) -> (result: String, isPositive: Bool)
    
    /// Method that handles the swipe action of an entrant to ride any rides or skip ride lines.
    /// Returns a tuple containing the swipe result message and swipe status.
    /// - Parameters:
    ///     - for: RidePrivilege
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool)
}

extension Swipable {
    
    func swipe(at checkpoint: AccessRequiredParkArea) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getPersonalizedBirthDayGreetingIfBirthDay()
        
        // To add a custom b'day greeting message if swiped on b'day.
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if accessibleAreas.contains(checkpoint) {
            result += "This pass can grant access to \(checkpoint.rawValue)."
            isPositive = true
        } else {
            result += "This pass cannot grant access to \(checkpoint.rawValue)."
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for parkDiscount: ParkDiscount) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getPersonalizedBirthDayGreetingIfBirthDay()
        
        // To add a custom b'day greeting message if swiped on b'day.
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        guard let discount = self.parkDiscount else {
            result += "This pass cannot be used to avail any food and merchandise discounts."
            isPositive = false
            return (result: result, isPositive: isPositive)
        }
        
        if discount == parkDiscount {
            result += "This pass can be used to avail \(parkDiscount.rawValue)."
            isPositive = true
        } else {
            result += "This pass cannot be used to avail \(parkDiscount.rawValue)."
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getPersonalizedBirthDayGreetingIfBirthDay()
        
        // To add a custom b'day greeting message if swiped on b'day.
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if ridePrivileges.contains(ridePrivilege) {
            result += "This pass can grant \(ridePrivilege.rawValue)."
            isPositive = true
            
        } else {
            result += "This pass cannot grant \(ridePrivilege.rawValue)."
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    /// Helper method to identify whether today is the pass owner's b'day.
    /// Returns true if it is his / her b'day.
    private func isTodayBirthday() -> Bool {
        if let dateOfBirth = passOwner.dateOfBirth {
            let todayMonthAndDay = Calendar.current.dateComponents([.month, .day], from: Date())
            let passOwnerBirthDay = Calendar.current.dateComponents([.month, .day], from: dateOfBirth)
            return todayMonthAndDay == passOwnerBirthDay
        } else {
            return false
        }
    }
    
    /// Helper method that composes a customized b'day greeting if today turns out to be
    /// the pass owner's b'day.
    /// Returns the custom b'day greeting string if it is his/her b'day or returns nil.
    func getPersonalizedBirthDayGreetingIfBirthDay() -> String? {
        var bdayGreeting: String?
        if isTodayBirthday() {
            bdayGreeting = "\nHappy Birthday"
            if let firstName = passOwner.firstName, let lastName = passOwner.lastName {
                bdayGreeting! += " \(firstName) \(lastName)!"
            } else {
                if let firstName = passOwner.firstName {
                    bdayGreeting! += " \(firstName)!"
                } else {
                    if let lastName = passOwner.lastName {
                        bdayGreeting! += " \(lastName)!"
                    } else {
                        bdayGreeting! += "!"
                    }
                }
            }
            bdayGreeting! += "\n"
        }
        return bdayGreeting
    }
    
    var passOwnerName: String {
        var name = ""
        if let firstName = passOwner.firstName, let lastName = passOwner.lastName {
            name = "\(firstName) \(lastName)"
        } else {
            if let firstName = passOwner.firstName {
                name = "\(firstName)"
            } else {
                if let lastName = passOwner.lastName {
                    name = "\(lastName)"
                } else {
                    name = "Anonymous"
                }
            }
        }
        return name
    }
}




