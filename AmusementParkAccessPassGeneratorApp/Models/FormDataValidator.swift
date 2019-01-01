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
    
    func validateNameField(with data: String) throws {
        if data.isEmpty == false {
            if !data.containsNoNumbers {
                throw ValidationError.invalidData(errorMessage: "Name should not contain any numbers.")
            }
            
            if !data.containsNoSpecialCharacters {
                throw ValidationError.invalidData(errorMessage: "Name should not contain any special characters.")
            }
            
            if data.count > maxUserInputDataLength {
                throw ValidationError.invalidDataLength(errorMessage: "Number of characters cannot exceed \(maxUserInputDataLength).")
            }
        }
    }
    
    func validateStreetAddressField(with data: String) throws {
        if data.isEmpty == false {
            if data.count < minUserInputDataLength {
                throw ValidationError.invalidDataLength(errorMessage: "Address is too short! Should contain atleast \(minUserInputDataLength).")
            } else if data.count > maxUserAddressLength {
                throw ValidationError.invalidDataLength(errorMessage: "Address is too long! Number of characters cannot exceed \(maxUserAddressLength).")
            }
        }
    }
    
    func validateLocationField(with data: String) throws {
        if data.isEmpty == false {
            if !data.containsNoNumbers {
                throw ValidationError.invalidData(errorMessage: "Should not contain any numbers.")
            }
            
            if !data.containsNoSpecialCharacters {
                throw ValidationError.invalidData(errorMessage: "Should not contain any special characters.")
            }
            
            if data.count < minUserInputDataLength {
                throw ValidationError.invalidDataLength(errorMessage: "Please enter atleast \(minUserInputDataLength) characters.")
            } else if data.count > maxUserInputDataLength {
                throw ValidationError.invalidDataLength(errorMessage: "Number of characters cannot exceed \(maxUserInputDataLength).")
            }
        }
    }
    
    func validateZipcodeField(with data: String) throws {
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
        }
    }
    
    func validateDate(with data: String) throws {
        if data.isEmpty == false {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            if dateFormatter.date(from: data) == nil {
                throw ValidationError.invalidDate(errorMessage: "Date should be in MM/DD/YYYY format.")
            }
        }
    }
    
    func validateProject(with data: String) throws {
        if data.isEmpty == false {
            if !data.containsOnlyNumbers {
                throw ValidationError.invalidProjectNumber(errorMessage: "Invalid Project #")
            }
        }
    }
    
    func validateCompany(with data: String) throws {
        if data.isEmpty == false {
            if !data.containsNoNumbers || !data.containsNoSpecialCharacters{
                throw ValidationError.invalidVendorCompany(errorMessage: "Invalid Company")
            }
        }
    }
    
    func validateManagementTier(with data: String) throws {
        if data.isEmpty == false {
            guard let tier = ManagementTier(rawValue: data) else {
                throw ValidationError.invalidManagementTier(errorMessage: "Invalid Management Tier")
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
