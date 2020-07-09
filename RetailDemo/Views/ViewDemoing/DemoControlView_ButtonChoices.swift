//
//  DemoControlView_ButtonChoices.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

struct DemoControlView_ButtonChoices<T>: View where T: Equatable {
    let buttons: [NamedIdentifiedValue<T>]
    @ObservedObject var preference: ObservableObjectWrapper<T>
    
    var body: some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer().frame(width: 50)
                ForEach(buttons, id: \.id) { button in
                    Button(action: {
                        self.preference.value = button.value
                    }) {
                        Text(button.title)
                            .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                            .overlay(
                                Capsule()
                                    .fill(
                                        self.capsuleFill(matching: button)
                                    )
                            )
                    }
                }
                Spacer()
            }
        }
        .font(Font.caption.bold())
        .foregroundColor(.primary)
    }
    
    func capsuleFill(matching namedIdentifiedValue: NamedIdentifiedValue<T>) -> Color {
        if namedIdentifiedValue.value == preference.value {
            return Color.primary.opacity(0.2)
        } else {
            return Color.primary.opacity(0.06)
        }
    }
}

