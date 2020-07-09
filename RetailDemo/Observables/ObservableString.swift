//
//  ObservableString.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Combine

typealias ObservableString = ObservableObjectWrapper<String>

extension ObservableString {
    var string: String {
        get {
            return self.value
        }
        set {
            self.value = newValue
        }
    }
    
    convenience init() {
        self.init("")
    }
}
