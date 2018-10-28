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
    var didShowBirthDayGreeting: Bool { get set }
    
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool, bdayGreeting: String?)
    func swipe(for parkDiscount: ParkDiscount?) -> (result: String, isPositive: Bool, bdayGreeting: String?)
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool, bdayGreeting: String?)
}

extension Swipable {
    
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool, bdayGreeting: String?) {
        let result: String
        let isPositive: Bool
        var bdayGreeting: String?
        
        if isTodayBirthday() {
            if let firstname = passOwner.firstName {
                bdayGreeting = "Many Many Happy Returns Of The Day, \(firstname)"
            }
        }
        
        if accessibleAreas.contains(checkpoint) {
            result = "Hi, \(passType.rawValue) user. You have been granted access to \(checkpoint.rawValue)."
            isPositive = true
        } else {
            result = "Sorry, as a \(passType.rawValue) user, you don't have access to \(checkpoint.rawValue)."
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
        
        guard let discount = parkDiscount else {
            result = "Sorry, as a \(passType.rawValue) user, You are not eligible for any discount"
            isPositive = false
            if didShowBirthDayGreeting {
                return (result: result, isPositive: isPositive, nil)
            } else {
                didShowBirthDayGreeting = true
                return (result: result, isPositive: isPositive, bdayGreeting: bdayGreeting)
            }
        }
        result = "Hi, \(passType.rawValue) user, You are eligible for \(discount.rawValue)"
        isPositive = true
        
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
        
        if ridePrivileges.contains(ridePrivilege) {
            result = "Hi, \(passType.rawValue) user, You have \(ridePrivilege.rawValue) access."
            isPositive = true
            
        } else {
            result = "Sorry, as a \(passType.rawValue) user, you don't have \(ridePrivilege.rawValue) access."
            isPositive = false
        }
        
        if didShowBirthDayGreeting {
            return (result: result, isPositive: isPositive, nil)
        } else {
            didShowBirthDayGreeting = true
            return (result: result, isPositive: isPositive, bdayGreeting: bdayGreeting)
        }
    }
    
    func isTodayBirthday() -> Bool {
        if let dateOfBirth = passOwner.dateOfBirth {
            let todayMonthAndDay = Calendar.current.dateComponents([.month, .day], from: Date())
            let dateOfBirthMonthAndDay = Calendar.current.dateComponents([.month, .day], from: dateOfBirth)
            return todayMonthAndDay == dateOfBirthMonthAndDay
        } else {
            return false
        }
    }
}




