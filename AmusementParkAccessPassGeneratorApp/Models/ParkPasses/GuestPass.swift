//
//  GuestPass.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation

class GuestPass: ParkPass {
    var lastAccessTime: Date?
    
    func updateLastAccessTime() {
        lastAccessTime = Date()
    }
    
    func canSwipe() -> Bool {
        let currentTime = Date()
        let currentTimeInSeconds = currentTime.timeIntervalSince1970
        if let lastAccessTime = lastAccessTime {
            let lastAccessTimeInSeconds = lastAccessTime.timeIntervalSince1970
            let timeDifference = Int(currentTimeInSeconds - lastAccessTimeInSeconds)
            return timeDifference > 5 ? true : false
        } else {
            return true
        }
    }
}
