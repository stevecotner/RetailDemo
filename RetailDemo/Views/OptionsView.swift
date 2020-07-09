//
//  OptionsView.swift
//  Poet
//
//  Created by Stephen E. Cotner on 5/21/20.
//  Copyright © 2020 Steve Cotner. All rights reserved.
//

import SwiftUI

protocol ActionEvaluating_OptionToggling: ActionEvaluating where Action: EvaluatorAction_OptionToggling {}

protocol EvaluatorAction_OptionToggling: EvaluatorAction {
    static func toggleOption(_ option: String) -> Self
}

struct OptionsView<E: ActionEvaluating_OptionToggling>: View {
    @Observed var options: [String]
    @Observed var preference: String
    let evaluator: E
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(options, id: \.self) { option in
                VStack(alignment: .leading, spacing: 0) {
                    OptionView(option: option, preference: self.preference, evaluator: self.evaluator)
                    Spacer().frame(height: 16)
                }
            }
            Spacer().frame(height: 18)
        }
    }
}

struct OptionView<E: ActionEvaluating_OptionToggling>: View {
    let option: String
    let preference: String
    let evaluator: E
    
    var body: some View {
        let isSelected = self.option == self.preference
        return Button(action: {
            self.evaluator.evaluate(.toggleOption(option))
        }) {
            HStack(spacing: 0) {
                ZStack(alignment: .topLeading) {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.primary)
                        .frame(width: isSelected ? 25.5 : 23, height: isSelected ? 25.5 : 23)
                        .animation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0), value: isSelected)
                        .padding(EdgeInsets(top: isSelected ? 0 : 1.25, leading: isSelected ? 38.75 : 40, bottom: isSelected ? 0 : 1.25, trailing: 0))
                    Text(self.option)
                        .font(Font.headline)
                        .layoutPriority(20)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(EdgeInsets(top: 1.25, leading: 76, bottom: 0, trailing: 76))
                }
                Spacer()
            }
        }
        .padding(0)
        .foregroundColor(.primary)
    }
}

// MARK: View Demoing

extension OptionsView: ViewDemoing {
    static var demoProvider: DemoProvider { return OptionsView_DemoProvider() }
}

struct OptionsView_DemoProvider: DemoProvider, ActionEvaluating_OptionToggling, TextFieldEvaluating {
    
    @Observable var text: String = ""
    @Observable var options: [String] = ["OptionA", "OptionB"]
    @Observable var preference: String = ""
    
    enum Element: EvaluatorElement {
        case optionsTextField
    }
    
    enum Action: EvaluatorAction_OptionToggling {
        case toggleOption(_ option: String)
    }
    
    func _evaluate(_ action: Action) {
        switch action {
        case .toggleOption(let option):
            if preference == option {
                preference = ""
            } else {
                preference = option
            }
        }
    }
    
    func deepCopy() -> Self {
        let provider = OptionsView_DemoProvider(
            text: self.$text.wrappedValue,
            options: self.$options.wrappedValue,
            preference: self.$preference.wrappedValue
        )
        return provider
    }
    
    var contentView: AnyView {
        return AnyView(
            OptionsView(
                options: $options,
                preference: $preference,
                evaluator: self)
        )
    }
    
    var controls: [DemoControl] {
        [
            DemoControl(
                title: "Options",
                instruction: "Type words separated by semicolons to add options.",
                type: DemoControl.Text(evaluator: self, elementName: Element.optionsTextField, input: .text, initialText: options.joined(separator: ";"))
            )
        ]
    }
    
//    func _toggleOption(_ option: String) {
//        if preference == option {
//            preference = ""
//        } else {
//            preference = option
//        }
//    }
    
    func textFieldDidChange(text: String, elementName: EvaluatorElement) {
        self.text = text
        let splitText = text.split(separator: ";").map { String($0) }
        if splitText.isEmpty {
            self.options = [" "]
        } else {
            self.options = splitText
        }
    }
}
