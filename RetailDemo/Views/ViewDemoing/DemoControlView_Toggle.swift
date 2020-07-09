//
//  DemoControlView_Toggle.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

struct DemoControlView_Toggle: View {
    @ObservedObject var title: ObservableString
    let elementName: EvaluatorElement
    let initialValue: Bool
    let evaluator: ToggleEvaluating
    
    
    var body: some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            EvaluatingToggle(title: title, elementName: elementName, initialValue: initialValue, evaluator: evaluator)
                .padding(.leading, 50)
                .padding(.trailing, 50)
                
        }
        .font(Font.caption.bold())
        .foregroundColor(.primary)
    }
}
