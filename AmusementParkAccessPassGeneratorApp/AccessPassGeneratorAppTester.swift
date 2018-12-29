//
//  ParkPassTester.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 30/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

/// Simulator to test various passes issued by the Amusement Park Access Pass Generator App.
struct AccessPassGeneratorAppTester {
    
    typealias SwipeResult = (result: String, isPositive: Bool)
    let audioPlayer = AudioPlayer()
    
    /// Method that runs all the main park passes and related tests.
    /// Exceptions are vendor and contract employee passes
    func testAllMainParkPasses() {
        testClassicGuestPass()
        testVIPGuestPass()
        testFreeChildGuestPass()
        testHourlyEmployeeFoodServicesPass()
        testHourlyEmployeeRideServicesPass()
        testHourlyEmployeeMaintenancePass()
        testManagerPass()
        testSeasonGuestPass()
        testSeniorGuestPass()
        testSwipeOnBirthDay()
    }
    
    /// Method that runs all the contract employee park passes and related tests.
    func testAllContractEmployeePasses() {
        testProject1001ContractEmployeePass()
        testProject1002ContractEmployeePass()
        testProject1003ContractEmployeePass()
        testProject2001ContractEmployeePass()
        testProject2002ContractEmployeePass()
    }
    
    /// Method that runs all the vendor park passes and related tests.
    func testAllVendorPasses() {
        testAcmeVendorPass()
        testOrkinVendorPass()
        testFedexVendorPass()
        testNWElectricalVendorPass()
    }
    
    /// Method to display a formatted result of a swipe action along with its status.
    func printToConsole(_ swipeOutput: SwipeResult) {
        let swipeStatus = swipeOutput.isPositive ? "Success" : "Failure"
        let result = """
        Swipe status: \(swipeStatus)
        Message: \(swipeOutput.result)
        """
        print("\n" + result + "\n")
    }
    
    /// Method that simulates an entrant swiping at a park area
    func swipe(_ pass: Swipable, at area: AccessRequiredParkArea) {
        let swipeOutput = pass.swipe(at: area)
        printToConsole(swipeOutput)
    }
    
    /// Method that simulates an entrant swiping at a ride area
    func swipe(_ pass: Swipable, for rideAccess: RidePrivilege) {
        let swipeOutput = pass.swipe(for: rideAccess)
        printToConsole(swipeOutput)
    }
    
    /// Method that simulates an entrant swiping at a shop or eatery for availing discount
    func swipe(_ pass: Swipable, toAvail discount: ParkDiscount) {
        let swipeOutput = pass.swipe(for: discount)
        printToConsole(swipeOutput)
    }
}


extension AccessPassGeneratorAppTester {
    
    /// Method that tests a Classic Guest Pass's conformance to business rules matrix provided by the park authorities.
    func testClassicGuestPass() {
        print("\n\n********** Testing Classic Guest Pass with no Entrant information. *********** \n")
        do {
            let classicGuestPass = try ClassicGuestPass()
            testRideAccess(of: classicGuestPass)
            testAreaAccess(of: classicGuestPass)
            testSkipAllRideLinesAccess(of: classicGuestPass)
            testDiscountAccess(of: classicGuestPass)
            testSecondSwipeAtSameRide(of: classicGuestPass)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        } catch let error {
            print(error)
        }
    }
    
    /// Method that tests a VIP Guest Pass's conformance to business rules matrix provided by the park authorities.
    func testVIPGuestPass() {
        print("\n\n********** Testing VIP Guest Pass with only first name and last name information. ************ \n")
        do {
            let vipGuestPass = try VIPGuestPass(firstName: "Vito", lastName: "Corleone")
            testRideAccess(of: vipGuestPass)
            testAreaAccess(of: vipGuestPass)
            testSkipAllRideLinesAccess(of: vipGuestPass)
            testDiscountAccess(of: vipGuestPass)
            testSecondSwipeAtSameRide(of: vipGuestPass)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        } catch let error {
            print(error)
        }
    }
    
    /// Method that tests a Free Child Guest Pass's conformance to business rules matrix provided by the park authorities.
    func testFreeChildGuestPass() {
        print("\n\n********** Testing Free Child Guest Pass with no date of birth information. ************ \n")
        do {
            let childGuestPass = try FreeChildGuestPass(dateOfBirth: nil)
        } catch let error {
            print(error)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        }
        print("\n\n********** Testing Free Child Guest Pass for a child younger than 5 years. ************ \n")
        do {
            // Set a custom date of birth to child entrant
            var dateComponents = DateComponents()
            dateComponents.year = 2018
            dateComponents.month = 7
            dateComponents.day = 13
            let calendar = Calendar.current
            let customDate = calendar.date(from: dateComponents)
            // Below step is done to ensure a date of birth that makes the entrant only 4 years of age with a b'day other than
            // today, thereby preventing the triggering of "Swiping on a b'day" bonus feature. This feature is tested
            // separately in testSwipeOnBirthDay()
            let childDateOfBirth = Calendar.current.date(byAdding: .year, value: -4, to: customDate!)!
            let childGuestPass = try FreeChildGuestPass(dateOfBirth: childDateOfBirth)
            testRideAccess(of: childGuestPass)
            testAreaAccess(of: childGuestPass)
            testSkipAllRideLinesAccess(of: childGuestPass)
            testDiscountAccess(of: childGuestPass)
            testSecondSwipeAtSameRide(of: childGuestPass)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        } catch let error {
            print(error)
        }
        print("\n\n********** Testing Free Child Guest Pass for a child older than 5 years. ************ \n")
        do {
            let childDateOfBirth = Calendar.current.date(byAdding: .year, value: -6, to: Date())!
            let childGuestPass = try FreeChildGuestPass(dateOfBirth: childDateOfBirth)
        } catch let error {
            print(error)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        }
    }
    
    /// Method that tests a Hourly Employee Food Service Pass's conformance to business rules matrix provided by the park authorities.
    func testHourlyEmployeeFoodServicesPass() {
        print("\n\n********** Testing Hourly Employee Food Service Pass without all required information. ************ \n")
        do {
            let dob = Calendar.current.date(byAdding: .year, value: -26, to: Date())!
            let foodServiceEmployeePass = try HourlyEmployeeFoodServicesPass(firstName: "Gary", lastName: nil,
                                                                     streetAddress: "59653 Candice Ports Apt",
                                                                     city: "Manhattan", state: "New York", zipcode: "10030", dateOfBirth: dob)
        } catch let error {
            print(error)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        }
        print("\n\n********** Testing Hourly Employee Food Service Pass with all required information. ************ \n")
        do {
            let dob = Calendar.current.date(byAdding: .year, value: -26, to: Date())!
            let foodServiceEmployeePass = try HourlyEmployeeFoodServicesPass(firstName: "Raheem", lastName: "Waters",
                                                                         streetAddress: "461 Rowena Lights", city: "Seattle",
                                                                         state: "Washington", zipcode: "98101", dateOfBirth: dob)
            testRideAccess(of: foodServiceEmployeePass)
            testAreaAccess(of: foodServiceEmployeePass)
            testSkipAllRideLinesAccess(of: foodServiceEmployeePass)
            testDiscountAccess(of: foodServiceEmployeePass)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        } catch let error {
            print(error)
        }
    }
    
    /// Method that tests a Hourly Employee Ride Service Pass's conformance to business rules matrix provided by the park authorities.
    func testHourlyEmployeeRideServicesPass() {
        print("\n\n********** Testing Hourly Employee Ride Service Pass without all required information. ************ \n")
        do {
            let rideServiceEmployeePass = try HourlyEmployeeRideServicesPass(firstName: "Eryn", lastName: "Wolf",
                                                                             streetAddress: "21097 Rashad Manors", city: "Dublin",
                                                                             state: "Leinster", zipcode: "94568", dateOfBirth: nil)
        } catch let error {
            print(error)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        }
        print("\n\n********** Testing Hourly Employee Ride Service Pass with all required information. ************ \n")
        do {
            let dob = Calendar.current.date(byAdding: .year, value: -26, to: Date())!
            let rideServiceEmployeePass = try HourlyEmployeeRideServicesPass(firstName: "Eryn", lastName: "Wolf",
                                                                             streetAddress: "46 Kildare street", city: "Dublin",
                                                                             state: "Leinster Province", zipcode: "94568", dateOfBirth: dob)
            testRideAccess(of: rideServiceEmployeePass)
            testAreaAccess(of: rideServiceEmployeePass)
            testSkipAllRideLinesAccess(of: rideServiceEmployeePass)
            testDiscountAccess(of: rideServiceEmployeePass)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        } catch let error {
            print(error)
        }
    }
    
    /// Method that tests a Hourly Employee Maintenance Pass's conformance to business rules matrix provided by the park authorities.
    func testHourlyEmployeeMaintenancePass() {
        print("\n\n********** Testing Hourly Employee Maintenance Pass without all required information. ************ \n")
        do {
            let dob = Calendar.current.date(byAdding: .year, value: -26, to: Date())!
            let maintenanceEmployeePass = try HourlyEmployeeMaintenancePass(firstName: "Yazmin", lastName: "West",
                                                                            streetAddress: "24 Baker Street", city: "London",
                                                                            state: "London", zipcode: nil, dateOfBirth: dob)
        } catch let error {
            print(error)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
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
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        } catch let error {
            print(error)
        }
    }
    
    /// Method that tests a Manager Pass's conformance to business rules matrix provided by the park authorities.
    func testManagerPass() {
        print("\n\n********** Manager Pass without all required information. ************ \n")
        do {
            let dob = Calendar.current.date(byAdding: .year, value: -36, to: Date())!
            let managerPass = try ManagerPass(firstName: "Larry", lastName: "Daley",
                                          streetAddress: "Upper West Side", city: nil, state: "New York", zipcode: "10031", dateOfBirth: dob)
        } catch let error {
            print(error)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        }
        print("\n\n********** Manager Pass with all required information. ************ \n")
        do {
            let dob = Calendar.current.date(byAdding: .year, value: -36, to: Date())!
            let managerPass = try ManagerPass(firstName: "Jonathan", lastName: "Pine",
                                              streetAddress: "Luxor Governate", city: "Luxor", state: "Cairo",
                                              zipcode: "387130", dateOfBirth: dob)
            testRideAccess(of: managerPass)
            testAreaAccess(of: managerPass)
            testSkipAllRideLinesAccess(of: managerPass)
            testDiscountAccess(of: managerPass)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
        } catch let error {
            print(error)
        }
    }
    
    /// Method that tests a Season Guest Pass's conformance to business rules matrix provided by the park authorities.
    func testSeasonGuestPass() {
        
    }
    
    /// Method that tests a Senior Guest Pass's conformance to business rules matrix provided by the park authorities.
    func testSeniorGuestPass() {
        
    }
    
    /// Method that tests a Project 1001 Contract Employee Pass's conformance to business rules matrix provided by the park authorities.
    func testProject1001ContractEmployeePass() {
        
    }
    
    /// Method that tests a Project 1002 Contract Employee Pass's conformance to business rules matrix provided by the park authorities.
    func testProject1002ContractEmployeePass() {
        
    }
    
    /// Method that tests a Project 1003 Contract Employee Pass's conformance to business rules matrix provided by the park authorities.
    func testProject1003ContractEmployeePass() {
        
    }
    
    /// Method that tests a Project 2001 Contract Employee Pass's conformance to business rules matrix provided by the park authorities.
    func testProject2001ContractEmployeePass() {
        
    }
    
    /// Method that tests a Project 2002 Contract Employee Pass's conformance to business rules matrix provided by the park authorities.
    func testProject2002ContractEmployeePass() {
        
    }
    
    /// Method that tests Acme Vendor Pass's conformance to business rules matrix provided by the park authorities.
    func testAcmeVendorPass() {
        
    }
    
    /// Method that tests Orkin Vendor Pass's conformance to business rules matrix provided by the park authorities.
    func testOrkinVendorPass() {
        
    }
    
    /// Method that tests Fedex Vendor Pass's conformance to business rules matrix provided by the park authorities.
    func testFedexVendorPass() {
        
    }
    
    /// Method that tests NW Electrical Vendor Pass's conformance to business rules matrix provided by the park authorities.
    func testNWElectricalVendorPass() {
        
    }
    
    /// Method that tests whether the bonus requirement of displaying personlized greeting messages to an entrant when swiped on a b'day is met or not.
    func testSwipeOnBirthDay() {
        print("\n********************* Testing whether personalized b'day greeting messages are displayed when an entrant swipes on his/her b'day ********************\n")
        print("1. Create a Classic Guest Pass including date of birth information and swipe on his/her b'day")
        let entrantDateOfBirth = Calendar.current.date(byAdding: .year, value: -29, to: Date())!
        do {
            let classicGuestPass = try ClassicGuestPass(firstName: "John", lastName: "Ritter", dateOfBirth: entrantDateOfBirth)
            swipe(classicGuestPass, at: .amusementArea)
        } catch let error {
            print(error)
        }
        print("2. Create a Manager Pass and swipe on his/her b'day")
        let managerDateOfBirth = Calendar.current.date(byAdding: .year, value: -35, to: Date())!
        do {
            let managerPass = try ManagerPass(firstName: "Molly", lastName: "Christiansen", streetAddress: "8695 Wilderman Hills",
                                              city: "Sauuerberg", state: "Sauuerberg State", zipcode: "89713", dateOfBirth: managerDateOfBirth)
            swipe(managerPass, toAvail: .managerDiscount)
        } catch let error {
            print(error)
        }
        print("3. Create a VIP Guest Pass with full name and date of birth and swipe on his/her b'day")
        let vipDateOfBirth = Calendar.current.date(byAdding: .year, value: -40, to: Date())!
        do {
            let vipGuestPass = try VIPGuestPass(firstName: "Felipa", lastName: "Herman", dateOfBirth: vipDateOfBirth)
            swipe(vipGuestPass, for: .skipAllRideLinesAccess)
        } catch let error {
            print(error)
        }
        print("4. Create an Hourly Employee Pass with date of birth but swipe on a day other than his/her b'day")
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
    
    /// Method that simulates swiping of a pass at all "pass accessible only" areas within the park.
    /// - Parameters:
    /// - pass: Any pass object that conforms to Swipable protocol.
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
    
    /// Method that simulates swiping of a pass at all rides to skip their ride lines.
    /// - Parameters:
    /// - pass: Any pass object that conforms to Swipable protocol.
    func testSkipAllRideLinesAccess(of pass: Swipable) {
        print("\nChecking skip all ride lines access of \(pass.passType.rawValue)")
        print("==================================================================================\n")
        swipe(pass, for: .skipAllRideLinesAccess)
        // To prevent triggering of "unauthorized swipe within 5 seconds" feature during test automation, wait for 6 seconds.
        sleep(6)
    }
    
    /// Method that simulates swiping of a pass at all ride areas within the park.
    /// - Parameters:
    /// - pass: Any pass object that conforms to Swipable protocol.
    func testRideAccess(of pass: Swipable) {
        print("\nTesting ride access of \(pass.passType.rawValue)")
        print("==================================================================================\n")
        swipe(pass, for: .allRidesAccess)
        // To prevent triggering of "unauthorized swipe within 5 seconds" feature during test automation, wait for 6 seconds.
        sleep(6)
    }
    
    /// Method that simulates swiping of a pass at eateries/shops with all available discount types.
    /// - Parameters:
    /// - pass: Any pass object that conforms to Swipable protocol.
    func testDiscountAccess(of pass: Swipable) {
        print("\nTesting discount access of \(pass.passType.rawValue)")
        print("==================================================================================\n")
        print("1. Checking \"Employee - Food and Merchandise\" discount access")
        swipe(pass, toAvail: .employeeDiscount)
        print("2. Checking \"Manager -  Food and Merchandise\" discount access")
        swipe(pass, toAvail: .managerDiscount)
        print("3. Checking \"VIP - Food and Merchandise\" discount access")
        swipe(pass, toAvail: .vipGuestDiscount)
    }
    
    /// Method that simulates unauthorized swiping of a pass at a ride area to sneak in a second person.
    /// - Parameters:
    /// - pass: Any GuestPass.
    func testSecondSwipeAtSameRide(of pass: GuestPass) {
        print("\nTest whether \(pass.passType.rawValue) user is prevented from swiping into the same ride twice in row within 5 seconds at the same checkpoint.")
        print("==========================================================================================================================\n")
        print("Checking first swipe at a ride checkpoint")
        swipe(pass, for: .allRidesAccess)
        print("Checking the quick second swipe at the same checkpoint to sneak in a buddy to the same ride")
        swipe(pass, for: .allRidesAccess)
    }
}
