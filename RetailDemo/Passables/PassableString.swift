//
//  PassableString.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation
import Combine

class PassableString {
    var subject = PassthroughSubject<String?, Never>()
    var string: String? {
        willSet {
            subject.send(newValue)
        }
    }
    
    func withString(_ string: String) {
        self.string = string
    }
}
