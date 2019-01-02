//
//  AccessPassCheckVC.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 30/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import UIKit

class AccessPassCheckVC: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var passOwnerNameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var accessPassPrivilegesLabel: UILabel!
    @IBOutlet weak var testResultsLabel: UILabel!
    
    // MARK: - Stored properties
    var parkAccessPass: Swipable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passOwnerNameLabel.text = parkAccessPass?.passOwnerName
        passTypeLabel.text = parkAccessPass?.passType.rawValue
    }
    
    // MARK: - IB Actions
    @IBAction func amusementAccessCheckButtonTapped(_ sender: Any) {
    }
    
    @IBAction func kitchenAccessCheckButtonTapped(_ sender: Any) {
    }
    
    @IBAction func rideControlsAccessCheckButtonTapped(_ sender: Any) {
    }
    
    @IBAction func maintenanceAccessCheckButtonTapped(_ sender: Any) {
    }
    
    @IBAction func officeAccessCheckButtonTapped(_ sender: Any) {
    }
    
    @IBAction func ridesAccessCheckButtonTapped(_ sender: Any) {
    }
    
    @IBAction func discountsAccessCheckButtonTapped(_ sender: Any) {
    }
    
    @IBAction func skipLinesAccessCheckButtonTapped(_ sender: Any) {
    }
    
    @IBAction func createPassButtonTapped(_ sender: Any) {
    }
    
    
    // MARK: - Methods
    
    // MARK: - Helper Methods

}
