//
//  NamedIdentifiedValue.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation

struct NamedIdentifiedValue<T>: Identifiable {
    let title: String
    let value: T
    let id: UUID = UUID()
}
