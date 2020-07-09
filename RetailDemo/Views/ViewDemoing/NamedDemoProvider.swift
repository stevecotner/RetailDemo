//
//  NamedDemoProvider.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation

struct NamedDemoProvider: DeepCopying {
    let title: String
    let demoProvider: DemoProvider
    var id: UUID = UUID()
    
    func deepCopy() -> Self {
        let provider = NamedDemoProvider(
            title: self.title,
            demoProvider: self.demoProvider.deepCopy(),
            id: self.id
        )
        return provider
    }
}
