//
//  ObservingTextView.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

struct ObservingTextView: View {
    
    @Observed var text: String
    var alignment: TextAlignment?
    var kerning: CGFloat
    
    
    init(_ text: Observed<String>, alignment: TextAlignment? = nil, kerning: CGFloat = 0) {
        self._text = text
        self.alignment = alignment
        self.kerning = kerning
    }
    
    var body: some View {
        Text(text)
            .kerning(kerning)
            .multilineTextAlignment(alignment ?? .leading)
    }
}

// MARK: Demo

extension ObservingTextView: ViewDemoing {
    static var demoProvider: DemoProvider { return ObservingTextView_DemoProvider() }
}

struct ObservingTextView_DemoProvider: DemoProvider, TextFieldEvaluating {
    typealias TextAlignmentNamedValue = NamedIdentifiedValue<TextAlignment>
    @Observable var text: String = "Hello"
    @Observable var alignment: TextAlignment = .leading
    @Observable var kerning: CGFloat = 0.0
    
    enum Element: EvaluatorElement {
        case textField
        case kerningField
    }
    
    var contentView: AnyView {
        AnyView(
            Observer2(_alignment.observableObjectWrapper, _kerning.observableObjectWrapper) { alignment, kerning in
                ObservingTextView(
                    self.$text,
                    alignment: alignment,
                    kerning: kerning
                )
            }
        )
    }
    
    var controls: [DemoControl] {
        [
            DemoControl(
                title: "Text",
                type: DemoControl.Text(
                    evaluator: self, elementName: Element.textField, input: .text, initialText: text
                )
            ),
            
            DemoControl(
                title: "Kerning",
                instruction: "Type any number, positive or negative.",
                type: DemoControl.Text(evaluator: self, elementName: Element.kerningField, input: .text, initialText: String(Double(kerning))
                )
            ),
            
            DemoControl(
                title: "Alignment",
                type: DemoControl.Buttons(
                    observable: _alignment.observableObjectWrapper,
                    choices:
                    [
                        TextAlignmentNamedValue(
                            title: "Leading",
                            value: TextAlignment.leading
                        ),
                        
                        TextAlignmentNamedValue(
                            title: "Center",
                            value: TextAlignment.center
                        ),
                        
                        TextAlignmentNamedValue(
                            title: "Trailing",
                            value: TextAlignment.trailing
                        )
                    ]
                )
            ),
        ]
    }
    
    func deepCopy() -> Self {
        let provider = ObservingTextView_DemoProvider(
            text: self.$text.wrappedValue,
            alignment: self.$alignment.wrappedValue,
            kerning: self.$kerning.wrappedValue
        )
        return provider
    }
    
    func textFieldDidChange(text: String, elementName: EvaluatorElement) {
        guard let elementName = elementName as? Element else {
            return
        }
        switch elementName {
        case .textField:
            self.text = text
        case .kerningField:
            self.kerning = CGFloat(Double(text) ?? 0.0)
        }
    }
}

// MARK: Preview

struct ObservingTextView_Previews: PreviewProvider {
    @Observable static var helloText: String = "Hello"
    static var previews: some View {
        ObservingTextView($helloText, alignment: .leading)
    }
}
