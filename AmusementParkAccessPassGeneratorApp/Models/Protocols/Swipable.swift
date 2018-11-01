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
    ///     - at: Any ParkAccessArea (enum type)
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool)
    
    /// Method that handles the swipe action of an entrant to receive discounts at eateries and shops.
    /// Returns a tuple containing the swipe result message and swipe status.
    /// - Parameters:
    ///     - for: ParkDiscount (enum type)
    func swipe(for parkDiscount: ParkDiscount) -> (result: String, isPositive: Bool)
    
    /// Method that handles the swipe action of an entrant to ride rides or skip ride lines
    /// Returns a tuple containing the swipe result message and swipe status.
    /// - Parameters:
    ///     - for: RidePrivilege (enum type)
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool)
}

extension Swipable {
    
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        // To add a custom b'day greeting message if swiped on b'day.
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if accessibleAreas.contains(checkpoint) {
            result += "You have access to \(checkpoint.rawValue)."
            isPositive = true
        } else {
            result += "Sorry, You don't have access to \(checkpoint.rawValue)."
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for parkDiscount: ParkDiscount) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        // To add a custom b'day greeting message if swiped on b'day.
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        guard let discount = self.parkDiscount else {
            result += "Sorry, You are not eligible for park discounts."
            isPositive = false
            return (result: result, isPositive: isPositive)
        }
        
        if discount == parkDiscount {
            result += "You are eligible to have \(discount.rawValue)."
            isPositive = true
        } else {
            result += "Sorry, You are not eligible to have \(discount.rawValue)."
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        // To add a custom b'day greeting message if swiped on b'day.
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if ridePrivileges.contains(ridePrivilege) {
            result += "You have \(ridePrivilege.rawValue) access."
            isPositive = true
            
        } else {
            result += "Sorry, You don't have \(ridePrivilege.rawValue) access."
            isPositive = false
        }
        return (result: result, isPositive: isPositive)
    }
    
    /// Helper method to identify whether today is the pass owner's b'day.
    /// Returns true if it is his / her b'day.
    func isTodayBirthday() -> Bool {
        if let dateOfBirth = passOwner.dateOfBirth {
            let todayMonthAndDay = Calendar.current.dateComponents([.month, .day], from: Date())
            let passOwnerBirthDay = Calendar.current.dateComponents([.month, .day], from: dateOfBirth)
            return todayMonthAndDay == passOwnerBirthDay
        } else {
            return false
        }
    }
    
    /// Helper method that composes a customized b'day greeting if today turns out to be
    /// pass owner's b'day.
    /// Returns the custom b'day greeting string if it is his/her b'day or returns nil.
    func getBirthDayGreetingIfBirthDay() -> String? {
        var bdayGreeting: String?
        if isTodayBirthday() {
            bdayGreeting = "\nHappy BirthDay"
            if let firstName = passOwner.firstName, let lastName = passOwner.lastName {
                bdayGreeting! += " \(firstName) \(lastName)! "
            } else {
                if let firstName = passOwner.firstName {
                    bdayGreeting! += " \(firstName)! "
                } else {
                    if let lastName = passOwner.lastName {
                        bdayGreeting! += " \(lastName)! "
                    } else {
                        bdayGreeting! += "! "
                    }
                }
            }
        }
        return bdayGreeting
    }
}




