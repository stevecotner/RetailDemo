//
//  ObservableValidation.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation

struct ObservableValidation {
    var isValid = ObservableBool()
    var message = ObservableString()
}
