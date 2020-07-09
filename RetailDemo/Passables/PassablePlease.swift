//
//  PassablePlease.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Combine

class PassablePlease {
    var subject = PassthroughSubject<Any?, Never>()
    func please() {
        subject.send(nil)
    }
}

