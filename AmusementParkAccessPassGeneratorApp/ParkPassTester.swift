//
//  ParkPassTester.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 30/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

typealias SwipeResult = (result: String, isPositive: Bool)

struct ParkPassTester {
    
    func testAllParkPasses() {
        testClassicGuestPass()
        testVIPGuestPass()
        // testFreeChildGuestPass()
        // testHourlyEmployeeFoodServicesPass()
        // testHourlyEmployeeRideServicesPass()
        // testHourlyEmployeeMaintenancePass()
        // testManagerPass()
        // testSwipeOnBirthDay()
        // testUnauthorizedSecondSwipe()
    }
    
    func testClassicGuestPass() {
        print("\n\n********** Testing creation of Classic Guest Pass with no Entrant information. *********** \n")
        do {
            let classicGuestPass = try ClassicGuestPass(firstName: nil, lastName: nil, dateOfBirth: nil, streetAddress: nil, city: nil, state: nil, zipcode: nil)
            testAreaAccess(of: classicGuestPass)
            testRideAccess(of: classicGuestPass)
            testDiscountAccess(of: classicGuestPass)
        } catch let error {
            print(error)
        }
    }
    
    func testVIPGuestPass() {
        print("\n\n********** Testing creation of VIP Guest Pass with few Entrant information. ************ \n")
        do {
            let vipGuestPass = try VIPGuestPass(firstName: "Vito", lastName: "Corleone", dateOfBirth: nil, streetAddress: nil, city: nil, state: nil, zipcode: nil)
            testAreaAccess(of: vipGuestPass)
            testRideAccess(of: vipGuestPass)
            testDiscountAccess(of: vipGuestPass)
        } catch let error {
            print(error)
        }
    }
    
    func testFreeChildGuestPass() {
        
    }
    
    func testHourlyEmployeeFoodServicesPass() {
        
    }
    
    func testHourlyEmployeeRideServicesPass() {
        
    }
    
    func testHourlyEmployeeMaintenancePass() {
        
    }
    
    func testManagerPass() {
        
    }
    
    func swipe(_ pass: Swipable, at area: ParkAccessArea) {
        let swipeOutput = pass.swipe(at: area)
        display(swipeOutput)
    }
    
    func swipe(_ pass: Swipable, for rideAccess: RidePrivilege) {
        let swipeOutput = pass.swipe(for: rideAccess)
        display(swipeOutput)
    }
    
    func swipe(_ pass: Swipable, for discount: ParkDiscount) {
        let swipeOutput = pass.swipe(for: discount)
        display(swipeOutput)
    }
    
    func testSwipeOnBirthDay() {
        
    }
    
    func testUnauthorizedSecondSwipe() {
        
    }
    
    func display(_ swipeOutput: SwipeResult) {
        let swipeStatus = swipeOutput.isPositive ? "Success" : "Failure"
        let result = """
        Swipe status: \(swipeStatus)
        Message: \(swipeOutput.result)
        """
        print("\n" + result + "\n")
    }
    
    func testAreaAccess(of pass: Swipable) {
        print("Testing area access of \(pass.passType.rawValue)")
        print("==================================================================================\n")
        print("1. Checking amusement area access")
        swipe(pass, at: .amusementArea)
        print("2. Checking kitchen area access")
        swipe(pass, at: .kitchenArea)
        print("3. Checking ride control area access")
        swipe(pass, at: .rideControlArea)
        print("4. Checking maintenance area access")
        swipe(pass, at: .maintenanceArea)
        print("5. Checking office area access")
        swipe(pass, at: .officeArea)
    }
    
    func testRideAccess(of pass: Swipable) {
        print("Testing ride access of \(pass.passType.rawValue)")
        print("==================================================================================\n")
        print("1. Checking all rides access")
        swipe(pass, for: .allRidesAccess)
        sleep(6)
        print("2. Checking skip all ride lines access")
        swipe(pass, for: .skipAllRideLinesAccess)
    }
    
    func testDiscountAccess(of pass: Swipable) {
        print("Testing discount access of \(pass.passType.rawValue)")
        print("==================================================================================\n")
        print("1. Checking employee - food and merchandise discount access")
        swipe(pass, for: .employeeDiscount)
        print("2. Checking manager -  food and merchandise discount access")
        swipe(pass, for: .managerDiscount)
        print("3. Checking vip - food and merchandise discount access")
        swipe(pass, for: .vipGuestDiscount)
    }
    
}
