//
//  Swipable.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//
import  Foundation

protocol Swipable {
    func swipe(at checkpoint: ParkAccessArea) -> (result: String, isPositive: Bool)
    func swipe(for parkDiscount: ParkDiscount?) -> (result: String, isPositive: Bool)
    func swipe(for ridePrivilege: RidePrivilege) -> (result: String, isPositive: Bool)
    // func checkForBirthDay()
}



