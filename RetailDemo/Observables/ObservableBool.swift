//
//  ObservableBool.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Combine

typealias ObservableBool = ObservableObjectWrapper<Bool>

extension ObservableBool {
    var bool: Bool {
        get {
            return self.value
        }
        set {
            self.value = newValue
        }
    }
    
    convenience init() {
        self.init(false)
    }
}
