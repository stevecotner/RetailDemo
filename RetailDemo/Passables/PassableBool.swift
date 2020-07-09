//
//  PassableBool.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation
import Combine

class PassableBool {
    var subject = PassthroughSubject<Bool?, Never>()
    var bool: Bool? {
        willSet {
            subject.send(newValue)
        }
    }
    
    func isTrue() {
        self.bool = true
    }
    
    func isFalse() {
        self.bool = false
    }
}
