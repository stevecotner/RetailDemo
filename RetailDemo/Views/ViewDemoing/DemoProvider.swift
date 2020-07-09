//
//  DemoProvider.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

/**
 You must implement the deepCopy() method on your DemoProvider by doing a deep copy of each observable.
 If you do not, the process of saving changes to a demo provider will be broken in the Demo Builder.
 */
protocol DemoProvider: DeepCopying {
    // to be determined upon use
    var contentView: AnyView { get }
    var controls: [DemoControl] { get }
    
    // provided by default implementation
    var demoContainerView: AnyView { get }
}

extension DemoProvider {
    var demoContainerView: AnyView {
        AnyView(
            VStack {
                DemoContainerView(
                    content: {
                        self.contentView
                    },
                    panel: {
                        DemoControlPanelView(self.controls)
                    }
                )
            }
        )
    }
}
