//
//  AccessPassFormPickerViews.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 02/01/19.
//  Copyright © 2019 AbhilashApps. All rights reserved.
//
enum AccessPassFormPickerView: Int {
    case project = 0
    case company
}

enum AccessPassFormDatePicker {
    case dateOfBirth
    case dateOfVisit
}

extension AccessPassFormPickerView {
    var tag: Int {
        return self.rawValue
    }
}

