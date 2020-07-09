//
//  PassableState.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation
import Combine

class PassableState<S: EvaluatorState> {
    var subject = PassthroughSubject<S, Never>()
    
    var state: S {
        willSet {
            subject.send(newValue)
        }
    }
        
    init(_ state: S) {
        self.state = state
    }
}
