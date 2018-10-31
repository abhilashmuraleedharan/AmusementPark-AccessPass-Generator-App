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
        // testClassicGuestPass()
        // testVIPGuestPass()
        // testFreeChildGuestPass() [Not working]
        // testHourlyEmployeeFoodServicesPass() [Coming as anonymous entrant]
        // testHourlyEmployeeRideServicesPass()
        // testHourlyEmployeeMaintenancePass()
        // testManagerPass()
        // testSwipeOnBirthDay()
    }
    
    func display(_ swipeOutput: SwipeResult) {
        let swipeStatus = swipeOutput.isPositive ? "Success" : "Failure"
        let result = """
        Swipe status: \(swipeStatus)
        Message: \(swipeOutput.result)
        """
        print("\n" + result + "\n")
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
}


extension ParkPassTester {
    
    func testClassicGuestPass() {
        print("\n\n********** Testing Classic Guest Pass with no Entrant information. *********** \n")
        do {
            let classicGuestPass = try ClassicGuestPass(firstName: nil, lastName: nil, dateOfBirth: nil, streetAddress: nil, city: nil, state: nil, zipcode: nil)
            testRideAccess(of: classicGuestPass)
            testAreaAccess(of: classicGuestPass)
            testSkipAllRideLinesAccess(of: classicGuestPass)
            testDiscountAccess(of: classicGuestPass)
            testSecondSwipeAtSameRide(of: classicGuestPass)
        } catch let error {
            print(error)
        }
    }
    
    func testVIPGuestPass() {
        print("\n\n********** Testing VIP Guest Pass with only first name and last name information. ************ \n")
        do {
            let vipGuestPass = try VIPGuestPass(firstName: "Vito", lastName: "Corleone", dateOfBirth: nil, streetAddress: nil, city: nil, state: nil, zipcode: nil)
            testRideAccess(of: vipGuestPass)
            testAreaAccess(of: vipGuestPass)
            testSkipAllRideLinesAccess(of: vipGuestPass)
            testDiscountAccess(of: vipGuestPass)
            testSecondSwipeAtSameRide(of: vipGuestPass)
        } catch let error {
            print(error)
        }
    }
    
    func testFreeChildGuestPass() {
        print("\n\n********** Testing Free Child Guest Pass with no date of birth information. ************ \n")
        do {
            let childGuestPass = try FreeChildGuestPass(dateOfBirth: nil)
        } catch let error {
            print(error)
        }
        print("\n\n********** Testing Free Child Guest Pass for a child younger than 5 years. ************ \n")
        do {
            let childDateOfBirth = Calendar.current.date(byAdding: .year, value: -4, to: Date())!
            let childGuestPass = try FreeChildGuestPass(dateOfBirth: childDateOfBirth)
            testRideAccess(of: childGuestPass)
            testAreaAccess(of: childGuestPass)
            testSkipAllRideLinesAccess(of: childGuestPass)
            testDiscountAccess(of: childGuestPass)
            testSecondSwipeAtSameRide(of: childGuestPass)
        } catch let error {
            print(error)
        }
        print("\n\n********** Testing Free Child Guest Pass for a child older than 5 years. ************ \n")
        do {
            let childDateOfBirth = Calendar.current.date(byAdding: .year, value: -6, to: Date())!
            let childGuestPass = try FreeChildGuestPass(dateOfBirth: childDateOfBirth)
        } catch let error {
            print(error)
        }
    }
    
    func testHourlyEmployeeFoodServicesPass() {
        print("\n\n********** Testing Hourly Employee Food Service Pass without all required information. ************ \n")
        do {
            let foodServiceEmployeePass = try HourlyEmployeeFoodServicesPass(firstName: "Gary", lastName: nil,
                                                                     streetAddress: "59653 Candice Ports Apt",
                                                                     city: "Manhattan", state: "New York", zipcode: "10030", dateOfBirth: nil)
        } catch let error {
            print(error)
        }
        print("\n\n********** Testing Hourly Employee Food Service Pass with all required information. ************ \n")
        do {
            let foodServiceEmployeePass = try HourlyEmployeeFoodServicesPass(firstName: "Raheem", lastName: "Waters",
                                                                         streetAddress: "461 Rowena Lights", city: "Seattle",
                                                                         state: "Washington", zipcode: "98101", dateOfBirth: nil)
            testRideAccess(of: foodServiceEmployeePass)
            testAreaAccess(of: foodServiceEmployeePass)
            testSkipAllRideLinesAccess(of: foodServiceEmployeePass)
            testDiscountAccess(of: foodServiceEmployeePass)
        } catch let error {
            print(error)
        }
    }
    
    func testHourlyEmployeeRideServicesPass() {
        print("\n\n********** Testing Hourly Employee Ride Service Pass without all required information. ************ \n")
        do {
            let rideServiceEmployeePass = try HourlyEmployeeRideServicesPass(firstName: "Eryn", lastName: "Wolf",
                                                                             streetAddress: nil, city: "Dublin",
                                                                             state: "Leinster", zipcode: "94568", dateOfBirth: nil)
        } catch let error {
            print(error)
        }
        print("\n\n********** Testing Hourly Employee Ride Service Pass with all required information. ************ \n")
        do {
            let rideServiceEmployeePass = try HourlyEmployeeRideServicesPass(firstName: "Eryn", lastName: "Wolf",
                                                                             streetAddress: "46 Kildare street", city: "Dublin",
                                                                             state: "Leinster Province", zipcode: "94568", dateOfBirth: nil)
            testRideAccess(of: rideServiceEmployeePass)
            testAreaAccess(of: rideServiceEmployeePass)
            testSkipAllRideLinesAccess(of: rideServiceEmployeePass)
            testDiscountAccess(of: rideServiceEmployeePass)
        } catch let error {
            print(error)
        }
    }
    
    func testHourlyEmployeeMaintenancePass() {
        print("\n\n********** Testing Hourly Employee Maintenance Pass without all required information. ************ \n")
        do {
            let maintenanceEmployeePass = try HourlyEmployeeMaintenancePass(firstName: "Yazmin", lastName: "West",
                                                                            streetAddress: "24 Baker Street", city: "London",
                                                                            state: "London", zipcode: nil, dateOfBirth: nil)
        } catch let error {
            print(error)
        }
        print("\n\n********** Testing Hourly Employee Maintenance Pass with all required information. ************ \n")
        do {
            let maintenanceEmployeePass = try HourlyEmployeeMaintenancePass(firstName: "Janick", lastName: "Walter",
                                                                            streetAddress: "117A Manners Street", city: "Wellington",
                                                                            state: "Wellington Region", zipcode: "33411", dateOfBirth: nil)
            testRideAccess(of: maintenanceEmployeePass)
            testAreaAccess(of: maintenanceEmployeePass)
            testSkipAllRideLinesAccess(of: maintenanceEmployeePass)
            testDiscountAccess(of: maintenanceEmployeePass)
        } catch let error {
            print(error)
        }
    }
    
    func testManagerPass() {
        print("\n\n********** Manager Pass without all required information. ************ \n")
        do {
            let managerPass = try ManagerPass(firstName: "Larry", lastName: "Daley",
                                          streetAddress: "Upper West Side", city: nil, state: "New York", zipcode: "10031", dateOfBirth: nil)
        } catch let error {
            print(error)
        }
        print("\n\n********** Manager Pass with all required information. ************ \n")
        do {
            let managerPass = try ManagerPass(firstName: "Jonathan", lastName: "Pine",
                                              streetAddress: "Luxor Governate", city: "Luxor", state: "Cairo",
                                              zipcode: "387130", dateOfBirth: nil)
            testRideAccess(of: managerPass)
            testAreaAccess(of: managerPass)
            testSkipAllRideLinesAccess(of: managerPass)
            testDiscountAccess(of: managerPass)
        } catch let error {
            print(error)
        }
    }
    
    func testSwipeOnBirthDay() {
        print("*********** Create a Classic Guest Pass with only date of birth and swipe on his/her b'day ***************")
        let entrantDateOfBirth = Calendar.current.date(byAdding: .year, value: -29, to: Date())!
        do {
            let classicGuestPass = try ClassicGuestPass(firstName: nil, lastName: nil, dateOfBirth: entrantDateOfBirth,
                                                        streetAddress: nil, city: nil, state: nil, zipcode: nil)
            swipe(classicGuestPass, at: .amusementArea)
        } catch let error {
            print(error)
        }
        print("*************** Create a Manager Pass and swipe on his/her b'day ********************")
        let managerDateOfBirth = Calendar.current.date(byAdding: .year, value: -35, to: Date())!
        do {
            let managerPass = try ManagerPass(firstName: "Molly", lastName: "Christiansen", streetAddress: "8695 Wilderman Hills",
                                              city: "Sauuerberg", state: "Sauuerberg State", zipcode: "89713", dateOfBirth: managerDateOfBirth)
            swipe(managerPass, for: .managerDiscount)
        } catch let error {
            print(error)
        }
        print("************* Create a VIP Guest Pass with full name and date of birth and swipe on his/her b'day ************************")
        let vipDateOfBirth = Calendar.current.date(byAdding: .year, value: -40, to: Date())!
        do {
            let vipGuestPass = try VIPGuestPass(firstName: "Felipa", lastName: "Herman", dateOfBirth: vipDateOfBirth, streetAddress: nil, city: nil, state: nil, zipcode: nil)
            swipe(vipGuestPass, for: .skipAllRideLinesAccess)
        } catch let error {
            print(error)
        }
        print("************** Create an Hourly Employee Pass with date of birth but swipe on a day other than his/her b'day ***************")
        var dateComponents = DateComponents()
        dateComponents.year = 1980
        dateComponents.month = 7
        dateComponents.day = 11
        dateComponents.timeZone = TimeZone(abbreviation: "MVT") // Maldives Time Zone
        dateComponents.hour = 8
        dateComponents.minute = 34
        let calendar = Calendar.current
        let employeeDateOfBirth = calendar.date(from: dateComponents)
        do {
            let hourlyEmployeeMaintenancePass = try HourlyEmployeeMaintenancePass(firstName: "George", lastName: "Bins", streetAddress: "Rollin Layout", city: "XYZ City", state: "ABC State", zipcode: "670702", dateOfBirth: employeeDateOfBirth)
            swipe(hourlyEmployeeMaintenancePass, at: .maintenanceArea)
        } catch let error {
            print(error)
        }
    }
    
    func testAreaAccess(of pass: Swipable) {
        print("\nTesting area access of \(pass.passType.rawValue)")
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
    
    func testSkipAllRideLinesAccess(of pass: Swipable) {
        print("\nChecking skip all ride lines access of \(pass.passType.rawValue)")
        print("==================================================================================\n")
        swipe(pass, for: .skipAllRideLinesAccess)
        sleep(6)
    }
    
    func testRideAccess(of pass: Swipable) {
        print("\nTesting ride access of \(pass.passType.rawValue)")
        print("==================================================================================\n")
        swipe(pass, for: .allRidesAccess)
        sleep(6)
    }
    
    func testDiscountAccess(of pass: Swipable) {
        print("\nTesting discount access of \(pass.passType.rawValue)")
        print("==================================================================================\n")
        print("1. Checking employee - food and merchandise discount access")
        swipe(pass, for: .employeeDiscount)
        print("2. Checking manager -  food and merchandise discount access")
        swipe(pass, for: .managerDiscount)
        print("3. Checking vip - food and merchandise discount access")
        swipe(pass, for: .vipGuestDiscount)
    }
    
    func testSecondSwipeAtSameRide(of pass: GuestPass) {
        print("\nTest whether \(pass.passType.rawValue) user is prevented from swiping into the same ride twice in row within 5 seconds at the same checkpoint.")
        print("==========================================================================================================================\n")
        print("Checking first swipe at a ride checkpoint")
        swipe(pass, for: .allRidesAccess)
        print("Checking second swipe at the same checkpoint within 5 seconds")
        swipe(pass, for: .allRidesAccess)
    }
}
