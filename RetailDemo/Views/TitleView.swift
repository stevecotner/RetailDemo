//
//  TitleView.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

struct TitleView: View {
    @Observed var text: String
    let color: Color
    
    // You've got to get clever if you want to be able to pass both observed and regular values for the same property
    private var staticTextObservableObjectWrapper = ObservableObjectWrapper<String>("")
    private var staticTextObserved: Observed<String> = Observed(observed: ObservableObjectWrapper<String>(""))
    
    init(staticText: String, color: Color) {
        staticTextObservableObjectWrapper = ObservableObjectWrapper<String>(staticText)
        staticTextObserved = Observed(observed: staticTextObservableObjectWrapper)
        _text = staticTextObserved
        self.color = color
    }
    
    init(text: Observed<String>, color: Color) {
        _text = text
        self.color = color
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(text)
                    .font(Font.system(size: 32, weight: .bold))
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            Spacer().frame(height: 24)
        }
        .foregroundColor(color)
    }
}

extension TitleView: ViewDemoing {
    static var demoProvider: DemoProvider {
        return TitleView_DemoProvider()
    }
}

struct TitleView_DemoProvider: DemoProvider, TextFieldEvaluating {
    @Observable var text: String = "Hello"
    var color = ObservableObjectWrapper<Color>(.primary)
    
    enum Element: EvaluatorElement {
        case text
    }
    
    var contentView: AnyView {
        return AnyView(
            Observer(color) { color in
                TitleView(
                    text: $text,
                    color: color
                )
            }
        )
    }
    
    var controls: [DemoControl] {
        return [
            DemoControl(
                title: "Text",
                type: DemoControl.Text(evaluator: self, elementName: Element.text, input: .text, initialText: text)
            ),
            
            DemoControl(
                title: "Color",
                type: DemoControl.Buttons(
                    observable: color,
                    choices: [
                        NamedIdentifiedValue(title: "Primary", value: Color.primary),
                        NamedIdentifiedValue(title: "Green", value: Color(UIColor.systemGreen)),
                        NamedIdentifiedValue(title: "Red", value: Color(UIColor.systemRed)),
                    ]
                )
            )
        ]
    }
    
    func deepCopy() -> TitleView_DemoProvider {
        let provider = TitleView_DemoProvider(
            text: self.$text.wrappedValue,
            color: self.color.deepCopy()
        )
        return provider
    }
    
    func textFieldDidChange(text: String, elementName: EvaluatorElement) {
        guard let elementName = elementName as? Element else { return }
        switch elementName {
        case .text:
            self.text = text
        }
    }
}
