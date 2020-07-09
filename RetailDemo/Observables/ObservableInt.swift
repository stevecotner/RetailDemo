//
//  ObservableInt.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation
import Combine

typealias ObservableInt = ObservableObjectWrapper<Int>

extension ObservableInt {
    var int: Int {
        get {
            return self.value
        }
        set {
            self.value = newValue
        }
    }
    
    convenience init() {
        self.init(0)
    }
}
