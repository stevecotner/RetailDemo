//
//  InstructionsView.swift
//  Poet
//
//  Created by Stephen E. Cotner on 5/21/20.
//  Copyright © 2020 Steve Cotner. All rights reserved.
//

import SwiftUI

struct InstructionsView: View {
    @Observed var instructions: [String]
    @Observed var focusableInstructionIndex: Int?
    @Observed var allowsCollapsingAndExpanding: Bool
    
    @State var isFocused: Bool = true
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<instructions.count, id: \.self) { instructionIndex in
                    VStack(alignment: .leading, spacing: 0) {
                        InstructionView(instructionNumber: instructionIndex + 1, instructionText: self.instructions[instructionIndex])
                            .frame(height: (self.allowsCollapsingAndExpanding && self.isFocused) ? (self.focusableInstructionIndex == instructionIndex ? nil : 0) : nil)
                            .opacity((self.allowsCollapsingAndExpanding) ? (self.isFocused ? (self.focusableInstructionIndex == instructionIndex ? 1 : 0) : (self.focusableInstructionIndex == instructionIndex ? 1 : 0.26)) : 1)
                    }
                }
                Spacer().frame(height: 18)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                VStack {
                    Button(
                        action: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0)) {
                                self.isFocused.toggle()
                            }
                    }) {
                        Image(systemName: self.isFocused ? "ellipsis.circle" : "xmark.circle" )
                            .frame(width: 24, height: 24)
                    }
                    .disabled(allowsCollapsingAndExpanding ? false : true)
                    .opacity(allowsCollapsingAndExpanding ? 1 : 0)
                    .foregroundColor(.primary)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 30)
                    
                    Spacer()
                }
            }
            .frame(width: 34, height: 50)
        }
    }
}


struct InstructionView: View {
    @Observed var instructionNumber: Int
    @Observed var instructionText: String
    
    private var staticInstructionNumberObservableObjectWrapper = ObservableObjectWrapper<Int>(1)
    private var staticInstructionNumberObserved: Observed<Int> = Observed(observed: ObservableObjectWrapper<Int>(1))
    
    private var staticInstructionTextObservableObjectWrapper = ObservableObjectWrapper<String>("")
    private var staticInstructionTextObserved: Observed<String> = Observed(observed: ObservableObjectWrapper<String>(""))
    
    init(instructionNumber: Int, instructionText: String) {
        staticInstructionNumberObservableObjectWrapper = ObservableObjectWrapper<Int>(instructionNumber)
        staticInstructionNumberObserved = Observed(observed: staticInstructionNumberObservableObjectWrapper)
        
        _instructionNumber = staticInstructionNumberObserved
        
        staticInstructionTextObservableObjectWrapper = ObservableObjectWrapper<String>(instructionText)
        staticInstructionTextObserved = Observed(observed: staticInstructionTextObservableObjectWrapper)
        
        _instructionText = staticInstructionTextObserved
    }
    
    init(instructionNumber: Observed<Int>, instructionText: Observed<String>) {
        _instructionNumber = instructionNumber
        _instructionText = instructionText
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ZStack(alignment: .topLeading) {
                    Image.numberCircleFill(instructionNumber)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.primary)
                        .frame(width: 24, height: 24)
                        .padding(EdgeInsets(top: 0, leading: 39.5, bottom: 0, trailing: 0))
                    Text(instructionText)
                        .font(Font.system(size: 17, weight: .bold).monospacedDigit())
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(EdgeInsets(top: 0, leading: 76, bottom: 0, trailing: 10))
                        .offset(x: 0, y: 2)
                }
                Spacer()
            }
            Spacer().frame(height: 18)
        }
    }
}

extension InstructionView: ViewDemoing {
    static var demoProvider: DemoProvider { return InstructionView_DemoProvider() }
}

struct InstructionView_DemoProvider: DemoProvider, TextFieldEvaluating {
    @Observable var number: Int = 1
    @Observable var instruction: String = "Just do it"
    
    enum Element: EvaluatorElement {
        case number
        case instruction
    }
    
    var contentView: AnyView {
        return AnyView(
            InstructionView(
                instructionNumber: $number,
                instructionText: $instruction
            )
        )
    }
    
    var controls: [DemoControl] {
        [
            DemoControl(
                title: "Number",
                instruction: "Type a number 1 through 50",
                type: DemoControl.Text(evaluator: self, elementName: Element.number, input: .number, initialText: String(number))
            ),
            
            DemoControl(
                title: "Instruction",
                type: DemoControl.Text(evaluator: self, elementName: Element.instruction, input: .text, initialText: instruction)
            )
        ]
    }
    
    func deepCopy() -> InstructionView_DemoProvider {
        return InstructionView_DemoProvider(
            number: $number.wrappedValue,
            instruction: $instruction.wrappedValue
        )
    }
    
    func textFieldDidChange(text: String, elementName: EvaluatorElement) {
        guard let elementName = elementName as? Element else { return }
        
        switch elementName {
        case .number:
            number = Int(text) ?? 0
        case .instruction:
            instruction = text
        }
    }
}

extension InstructionsView: ViewDemoing {
    static var demoProvider: DemoProvider { return InstructionsView_DemoProvider() }
}

struct InstructionsView_DemoProvider: DemoProvider, TextFieldEvaluating, ToggleEvaluating {
    @Observable var instructions: [String] = ["Just do it", "Do something else", "And another thing"]
    @Observable var focusedInstructionIndex: Int? = 1
    @Observable var allowsCollapsingAndExpanding: Bool = false
    
    enum Element: EvaluatorElement {
        case text
        case toggle
    }
    
    var contentView: AnyView {
        return AnyView(
            InstructionsView(
                instructions: $instructions,
                focusableInstructionIndex: $focusedInstructionIndex,
                allowsCollapsingAndExpanding: $allowsCollapsingAndExpanding)
        )
    }
    
    var controls: [DemoControl] {
        return [
            DemoControl(
                title: "Instructions",
                instruction: "Type instructions separated by semicolons",
                type: DemoControl.Text(
                    evaluator: self,
                    elementName: Element.text,
                    input: .text,
                    initialText: instructions.joined(separator: ";"))),
            
            DemoControl(
                title: "Collapsing and Expanding",
                instruction: "Type instructions separated by semicolons",
                type: DemoControl.Toggle(
                    evaluator: self,
                    elementName: Element.toggle,
                    title: "Allow Collapsing and Expanding",
                    initialValue: allowsCollapsingAndExpanding))
        ]
    }
    
    func textFieldDidChange(text: String, elementName: EvaluatorElement) {
        instructions = text.split(separator: ";").map{ String($0) }
    }
    
    func toggleDidChange(bool: Bool, elementName: EvaluatorElement) {
        allowsCollapsingAndExpanding = bool
    }
    
    func deepCopy() -> InstructionsView_DemoProvider {
        let demoProvider = InstructionsView_DemoProvider(
            instructions: $instructions.wrappedValue,
            focusedInstructionIndex: $focusedInstructionIndex.wrappedValue,
            allowsCollapsingAndExpanding: $allowsCollapsingAndExpanding.wrappedValue
        )
        return demoProvider
    }
}
