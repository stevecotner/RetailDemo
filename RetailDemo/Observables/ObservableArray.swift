//
//  ObservableArray.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Combine

typealias ObservableArray<A> = ObservableObjectWrapper<Array<A>>

extension ObservableArray {
    var array: T {
        get {
            return self.value
        }
        set {
            self.value = newValue
        }
    }
}
