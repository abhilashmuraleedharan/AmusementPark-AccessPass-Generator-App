//
//  FormDataValidator.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 01/01/19.
//  Copyright © 2019 AbhilashApps. All rights reserved.
//
import Foundation

enum ValidationError: Error {
    case invalidData(errorMessage: String)
    case invalidDataLength(errorMessage: String)
    case invalidDate(errorMessage: String)
    case invalidProjectNumber(errorMessage: String)
    case invalidVendorCompany(errorMessage: String)
    case invalidManagementTier(errorMessage: String)
}

struct FormDataValidator {
    let minUserInputDataLength = 5
    let maxUserInputDataLength = 15
    let maxUserAddressLength = 40
    let minZipcodeLength = 5
    let maxZipcodeLength = 10
    
    let projectList = ["\(ContractorPass.project1001.rawValue)", "\(ContractorPass.project1002.rawValue)",
        "\(ContractorPass.project1003.rawValue)", "\(ContractorPass.project2001.rawValue)", "\(ContractorPass.project2002.rawValue)"]
    let vendorCompanyList = ["\(VendorCompanyPass.acme.rawValue)", "\(VendorCompanyPass.fedex.rawValue)", "\(VendorCompanyPass.orkin.rawValue)",
        "\(VendorCompanyPass.nwelectrical.rawValue)"]
    let managementTierList = ["\(ManagementTier.shift.rawValue)", "\(ManagementTier.general.rawValue)", "\(ManagementTier.senior.rawValue)"]
    
    func validateFirstNameField(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                if !data.containsNoNumbers {
                    throw ValidationError.invalidData(errorMessage: "First Name should not contain any numbers.")
                }
                
                if !data.containsNoSpecialCharacters {
                    throw ValidationError.invalidData(errorMessage: "First Name should not contain any special characters.")
                }
                
                if data.count > maxUserInputDataLength {
                    throw ValidationError.invalidDataLength(errorMessage: "First Name cannot exceed \(maxUserInputDataLength) characters.")
                }
            } else {
                inputData = nil
            }
        }
    }
    
    func validateLastNameField(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                if !data.containsNoNumbers {
                    throw ValidationError.invalidData(errorMessage: "Last Name should not contain any numbers.")
                }
                
                if !data.containsNoSpecialCharacters {
                    throw ValidationError.invalidData(errorMessage: "Last Name should not contain any special characters.")
                }
                
                if data.count > maxUserInputDataLength {
                    throw ValidationError.invalidDataLength(errorMessage: "Last Name cannot exceed \(maxUserInputDataLength) characters.")
                }
            } else {
                inputData = nil
            }
        }
    }
    
    func validateStreetAddressField(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                if data.count < minUserInputDataLength {
                    throw ValidationError.invalidDataLength(errorMessage: "Street Address is too short! Should contain atleast \(minUserInputDataLength).")
                } else if data.count > maxUserAddressLength {
                    throw ValidationError.invalidDataLength(errorMessage: "Street Address is too long! Number of characters cannot exceed \(maxUserAddressLength).")
                }
            } else {
                inputData = nil
            }
        }
    }
    
    func validateCityField(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                if !data.containsNoNumbers {
                    throw ValidationError.invalidData(errorMessage: "City name should not contain any numbers.")
                }
                
                if !data.containsNoSpecialCharacters {
                    throw ValidationError.invalidData(errorMessage: "City name should not contain any special characters.")
                }
                
                if data.count < minUserInputDataLength {
                    throw ValidationError.invalidDataLength(errorMessage: "City name should have atleast \(minUserInputDataLength) characters.")
                } else if data.count > maxUserInputDataLength {
                    throw ValidationError.invalidDataLength(errorMessage: "City name cannot exceed \(maxUserInputDataLength) characters.")
                }
            } else {
                inputData = nil
            }
        }
    }
    
    func validateStateField(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                if !data.containsNoNumbers {
                    throw ValidationError.invalidData(errorMessage: "State name should not contain any numbers.")
                }
                
                if !data.containsNoSpecialCharacters {
                    throw ValidationError.invalidData(errorMessage: "State name should not contain any special characters.")
                }
                
                if data.count < minUserInputDataLength {
                    throw ValidationError.invalidDataLength(errorMessage: "State name should have atleast \(minUserInputDataLength) characters.")
                } else if data.count > maxUserInputDataLength {
                    throw ValidationError.invalidDataLength(errorMessage: "State name cannot exceed \(maxUserInputDataLength) characters.")
                }
            } else {
                inputData = nil
            }
        }
    }
    
    func validateZipcodeField(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                if !data.containsOnlyNumbers {
                    throw ValidationError.invalidData(errorMessage: "Zipcode should contain only numbers.")
                }
                
                if data.count < minZipcodeLength {
                    throw ValidationError.invalidDataLength(errorMessage: "Zipcode is too short! Should contain atleast \(minZipcodeLength) digits.")
                }
                
                if data.count > maxZipcodeLength {
                    throw ValidationError.invalidDataLength(errorMessage: "Zipcode is too long! Should not exceed \(maxZipcodeLength) digits.")
                }
            } else {
                inputData = nil
            }
        }
    }
    
    func validateDate(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                if dateFormatter.date(from: data) == nil {
                    throw ValidationError.invalidDate(errorMessage: "Date should be in MM/DD/YYYY format.")
                }
            } else {
                inputData = nil
            }
        }
    }
    
    func validateProject(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                if !data.containsOnlyNumbers {
                    throw ValidationError.invalidProjectNumber(errorMessage: "Invalid Project #")
                }
                if !projectList.contains(data) {
                    throw ValidationError.invalidProjectNumber(errorMessage: "Invalid Project #")
                }
            } else {
                inputData = nil
            }
        }
    }
    
    func validateCompany(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                if !data.containsNoNumbers || !data.containsNoSpecialCharacters{
                    throw ValidationError.invalidVendorCompany(errorMessage: "Invalid Vendor Company")
                }
                let parkVendors = vendorCompanyList.map { $0.lowercased() }
                if !parkVendors.contains(data.lowercased()) {
                    throw ValidationError.invalidVendorCompany(errorMessage: "Invalid Vendor Company")
                }
            } else {
                inputData = nil
            }
        }
    }
    
    func validateManagementTier(with inputData: inout String?) throws {
        if let data = inputData {
            if data.isEmpty == false {
                if !data.containsNoNumbers || !data.containsNoSpecialCharacters{
                    throw ValidationError.invalidManagementTier(errorMessage: "Invalid Management Tier")
                }
                let tiers = managementTierList.map { $0.lowercased() }
                if !tiers.contains(data.lowercased()) {
                    throw ValidationError.invalidManagementTier(errorMessage: "Invalid Management Tier")
                }
            } else {
                inputData = nil
            }
        }
    }
}

extension String {
    var containsNoNumbers: Bool {
        let numericalLiterals = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for num in numericalLiterals {
            if self.contains(num) {
                return false
            }
        }
        return true
    }
    
    var containsNoSpecialCharacters: Bool {
        let specialCharacters = ["`", "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "=", "+", "{", "}", "[", "]", "\\",
                                 ";", ":", "<", ">", ",", ".", "?", "/", "\"", "'"]
        for character in specialCharacters {
            if self.contains(character) {
                return false
            }
        }
        return true
    }
    
    var containsOnlyNumbers: Bool {
        for character in self {
            if !character.isNumber {
                return false
            }
        }
        return true
    }
}

extension Character {
    var isNumber: Bool {
        if self == "0" || self == "1" || self == "2" || self == "3" || self == "4" || self == "5" || self == "6" || self == "7" || self == "8" || self == "9" {
            return true
        } else {
            return false
        }
    }
}
