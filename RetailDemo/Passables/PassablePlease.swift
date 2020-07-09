//
//  PassablePlease.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Combine

struct Please {}

typealias PassablePlease = Passable<Please>

extension PassablePlease {
    func please() {
        subject.send(nil)
    }
}
