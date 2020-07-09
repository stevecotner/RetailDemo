//
//  DemoControlView_ObservableControlledByTextInput.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

struct DemoControlView_ObservableControlledByTextInput: View {
    let evaluator: TextFieldEvaluating
    let elementName: EvaluatorElement
    let input: EvaluatingTextField.Input
    let initialText: String
    
    var body: some View {
        EvaluatingTextField(placeholder: "", elementName: elementName, isSecure: false, input: input, evaluator: evaluator, initialText: initialText)
            .padding(.bottom, -10)
    }
}
