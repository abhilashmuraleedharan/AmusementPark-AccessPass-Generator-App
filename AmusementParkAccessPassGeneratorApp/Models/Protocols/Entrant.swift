//
//  Entrant.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
import  Foundation

protocol Entrant {
    var firstName: String? { get set }
    var lastName: String? { get set }
    var streetAddress: String? { get set }
    var city: String? { get set }
    var state: String? { get set }
    var zipcode: String? { get set }
    var dateOfBirth: Date? { get set }
    
    init(selectedPassType: PassSubType,firstName: String?, lastName: String?, streetAddress: String?,
    city: String?, state: String?, zipcode: String?, dateOfBirth: Date?) throws
}

