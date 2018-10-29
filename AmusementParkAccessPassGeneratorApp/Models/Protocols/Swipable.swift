//
//  Swipable.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
import  Foundation

protocol Swipable: class {
    var passOwner: ParkEntrant { get }
    var passType: PassSubCategory { get }
    var accessibleAreas: [ParkAccessArea] { get }
    var ridePrivileges: [RidePrivilege] { get }
    var parkDiscount: ParkDiscount? { get set }
    
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool)
    func swipe(for parkDiscount: ParkDiscount?) -> (result: String, isPositive: Bool)
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool)
}

extension Swipable {
    
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if accessibleAreas.contains(checkpoint) {
            result += "You are a \(passType.rawValue) user. You have access to \(checkpoint.rawValue)."
            isPositive = true
        } else {
            result += "Sorry, you're a \(passType.rawValue) user. You don't have access to \(checkpoint.rawValue)."
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
        
        guard let discount = parkDiscount else {
            result += "Sorry, you're a \(passType.rawValue) user. You are not eligible for park discounts."
            isPositive = false
            return (result: result, isPositive: isPositive)
        }
        
        result += "You are a \(passType.rawValue) user. You are eligible to have \(discount.rawValue)."
        isPositive = true
        
        return (result: result, isPositive: isPositive)
    }
    
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool) {
        var result = ""
        let isPositive: Bool
        let bdayGreeting = getBirthDayGreetingIfBirthDay()
        
        if let greeting = bdayGreeting {
            result = greeting
        }
        
        if ridePrivileges.contains(ridePrivilege) {
            result += "You are a \(passType.rawValue) user. You have \(ridePrivilege.rawValue) access."
            isPositive = true
            
        } else {
            result += "Sorry, you're a \(passType.rawValue) user. You don't have \(ridePrivilege.rawValue) access."
            isPositive = false
        }
        
        return (result: result, isPositive: isPositive)
    }
    
    func isTodayBirthday() -> Bool {
        if let dateOfBirth = passOwner.dateOfBirth {
            let todayMonthAndDay = Calendar.current.dateComponents([.month, .day], from: Date())
            let passOwnerBirthDay = Calendar.current.dateComponents([.month, .day], from: dateOfBirth)
            return todayMonthAndDay == passOwnerBirthDay
        } else {
            return false
        }
    }
    
    func getBirthDayGreetingIfBirthDay() -> String? {
        var bdayGreeting: String?
        if isTodayBirthday() {
            bdayGreeting = "Happy BirthDay"
            if let firstName = passOwner.firstName {
                bdayGreeting! += " \(firstName)\n"
            } else {
                if let lastName = passOwner.lastName {
                    bdayGreeting! += " \(lastName)\n"
                } else {
                    bdayGreeting! += "\n"
                }
            }
        }
        return bdayGreeting
    }
}




