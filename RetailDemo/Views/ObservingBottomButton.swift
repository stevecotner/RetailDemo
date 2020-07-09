//
//  ObservingBottomButton.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

struct ObservingBottomButton<E: ActionEvaluating>: View {
    @Observed var observableNamedEnabledAction: NamedEnabledEvaluatorAction<E.Action>?
    let evaluator: E?
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        GeometryReader() { geometry in
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    Button(action: {
                        self.evaluator?.evaluate(self.observableNamedEnabledAction?.action)
                    }) {
                        
                        Text(
                            self.observableNamedEnabledAction?.name ?? "")
                            .animation(.none)
                            .font(Font.headline)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(width: geometry.size.width - 100)
                            .padding(EdgeInsets(top: 16, leading: 18, bottom: 16, trailing: 18))
                            .background(
                                ZStack {
                                    BlurView()
                                    Rectangle()
                                        .fill(Color.primary.opacity(0.95))
                                }
                                .mask(
                                    Capsule()
                                )
                            )
                    }
                    .disabled(self.observableNamedEnabledAction?.enabled == false)
                    Spacer(minLength: 0)
                }
            }
        }
        
        .opacity(
            self.observableNamedEnabledAction?.action == nil ? 0 : 1
        )
        .offset(x: 0, y: self.observableNamedEnabledAction?.action == nil ? 150 : 0)
            .offset(x: 0, y: -self.keyboard.currentHeight)
            .animation(.spring(response: 0.35, dampingFraction: 0.7, blendDuration: 0), value: self.observableNamedEnabledAction?.action == nil)
            .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0), value: self.keyboard.currentHeight == 0)
    }
}
