//
//  EvaluatingToggle.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

protocol ToggleEvaluating {
    func toggleDidChange(bool: Bool, elementName: EvaluatorElement)
}

struct EvaluatingToggle: View {
    @ObservedObject var title: ObservableString
    let elementName: EvaluatorElement
    @ObservedObject private var isOn = ObservableBool()
    private var passableBool: PassableBool // <-- Not yet used. This will allow setting the bool imperatively.
    let evaluator: ToggleEvaluating
    
    init(title: ObservableString, elementName: EvaluatorElement, initialValue: Bool, passableBool: PassableBool? = nil, evaluator: ToggleEvaluating) {
        self.title = title
        self.elementName = elementName
        self.passableBool = passableBool ?? PassableBool()
        self.evaluator = evaluator
        self.isOn.bool = initialValue
    }
    
    var body: some View {
        Toggle(isOn: $isOn.bool) {
            Text(title.string)
        }
            .onReceive(isOn.objectDidChange) {
                self.evaluator.toggleDidChange(bool: self.isOn.bool, elementName: self.elementName)
        }
    }
}
