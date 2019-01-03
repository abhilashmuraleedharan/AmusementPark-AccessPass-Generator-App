//
//  AccessPassCheckVC.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 30/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import UIKit

class AccessPassCheckVC: UIViewController {
    
    typealias SwipeOutput = (result: String, isPositive: Bool)
    
    // MARK: - IB Outlets
    @IBOutlet weak var passOwnerNameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var accessPassPrivilegesLabel: UILabel!
    @IBOutlet weak var testResultsLabel: UILabel!
    
    // MARK: - Stored properties
    var parkAccessPass: Swipable?
    var audioPlayer = AudioPlayer()
    let testResultsLabelAccessDeniedBackgroundColor = UIColor(red: 255/255, green: 38/255, blue: 0, alpha: 1.0)
    let testResultsLabelAccessAllowedBackgroundColor = UIColor(red: 7/255, green: 147/255, blue: 73/255, alpha: 1.0)
    let testResultsLabelOutputFontColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passOwnerNameLabel.text = parkAccessPass?.passOwnerName
        passTypeLabel.text = parkAccessPass?.passType.rawValue
        displayAccessPassPrivileges()
    }
    
    // MARK: - IB Actions
    @IBAction func amusementAccessCheckButtonTapped(_ sender: Any) {
        if let swipeOutput = parkAccessPass?.swipe(at: .amusementArea) {
            display(swipeOutput)
        }
    }
    
    @IBAction func kitchenAccessCheckButtonTapped(_ sender: Any) {
        if let swipeOutput = parkAccessPass?.swipe(at: .kitchenArea) {
            display(swipeOutput)
        }
    }
    
    @IBAction func rideControlsAccessCheckButtonTapped(_ sender: Any) {
        if let swipeOutput = parkAccessPass?.swipe(at: .rideControlArea) {
            display(swipeOutput)
        }
    }
    
    @IBAction func maintenanceAccessCheckButtonTapped(_ sender: Any) {
        if let swipeOutput = parkAccessPass?.swipe(at: .maintenanceArea) {
            display(swipeOutput)
        }
    }
    
    @IBAction func officeAccessCheckButtonTapped(_ sender: Any) {
        if let swipeOutput = parkAccessPass?.swipe(at: .officeArea) {
            display(swipeOutput)
        }
    }
    
    @IBAction func ridesAccessCheckButtonTapped(_ sender: Any) {
        if let swipeOutput = parkAccessPass?.swipe(for: .allRidesAccess) {
            display(swipeOutput)
        }
    }
    
    @IBAction func discountsAccessCheckButtonTapped(_ sender: Any) {
        if let pass = parkAccessPass {
            let swipeOutput: SwipeOutput
            switch pass.passType {
            case .vipGuestPass:
                swipeOutput = pass.swipe(for: .vipGuestDiscount)
            case .hourlyEmployeeFoodServicePass, .hourlyEmployeeMaintenancePass, .hourlyEmployeeRideServicePass:
                swipeOutput = pass.swipe(for: .employeeDiscount)
            case .managerPass:
                swipeOutput = pass.swipe(for: .managerDiscount)
            case .seniorGuestPass:
                swipeOutput = pass.swipe(for: .seniorGuestDiscount)
            case .seasonGuestPass:
                swipeOutput = pass.swipe(for: .seasonPassGuestDiscount)
            default: swipeOutput = (result: "This pass cannot be used to avail any food and merchandise discounts.", isPositive: false)
            }
            display(swipeOutput)
        }
    }
    
    @IBAction func skipLinesAccessCheckButtonTapped(_ sender: Any) {
        if let swipeOut = parkAccessPass?.swipe(for: .skipAllRideLinesAccess) {
            display(swipeOut)
        }
    }
    
    // MARK: - Methods
    func display(_ output: SwipeOutput) {
        if output.isPositive {
            audioPlayer.playAlert(for: .accessGranted)
            testResultsLabel.backgroundColor = testResultsLabelAccessAllowedBackgroundColor
        } else {
            audioPlayer.playAlert(for: .accessDenied)
            testResultsLabel.backgroundColor = testResultsLabelAccessDeniedBackgroundColor
        }
        testResultsLabel.textColor = testResultsLabelOutputFontColor
        testResultsLabel.text = output.result
    }
    
    func displayAccessPassPrivileges() {
        var privileges = ""
        if let ridePrivileges = parkAccessPass?.ridePrivileges {
            for accessType in ridePrivileges {
                privileges += "* \(accessType.description)\n"
            }
        }
        if let discount = parkAccessPass?.parkDiscount {
            privileges += "* \(discount.foodDiscount)% Food discount\n"
            privileges += "* \(discount.merchandiseDiscount)% Merchandise discount"
        } else {
            privileges += "* 0% Food discount\n"
            privileges += "* 0% Merchandise discount"
        }
        accessPassPrivilegesLabel.text = privileges
    }

}
