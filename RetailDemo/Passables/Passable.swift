//
//  Passable.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 7/9/20.
//

import Combine
import Foundation
import SwiftUI

@propertyWrapper
class Passable<S> {
    var subject = PassthroughSubject<S?, Never>()
    
    var wrappedValue: S? {
        willSet {
            subject.send(newValue)
        }
    }
    
    var projectedValue: Passable<S> {
        return self
    }

    init(wrappedValue: S?) {
        self.wrappedValue = wrappedValue
    }
}
