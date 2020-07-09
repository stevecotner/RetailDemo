//
//  RetailScreen.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

struct Retail {}

extension Retail {
    struct Screen: View {
        
        let evaluator: Retail.Evaluator
        let translator: Retail.Translator
        
        init() {
            debugPrint("init retail screen")
            evaluator = Evaluator()
            translator = evaluator.translator
        }
        
        @State var navBarHidden: Bool = true
        
        var body: some View {
            ZStack {
                
                // MARK: Page View
                ObservingPageView(
                    sections: self.translator.$sections,
                    viewMaker: Retail.ViewMaker(
                        evaluator: evaluator
                    )
                )

                // MARK: Dismiss Button
                
                VStack {
                    DismissButton(orientation: .right)
                    DismissReceiver(translator.$dismiss)
                    Spacer()
                }
                
                // MARK: Bottom Button
                
                VStack {
                    Spacer()
                    ObservingBottomButton(observableNamedEnabledAction: self.translator.$bottomButtonAction, evaluator: evaluator)
                }
            }.onAppear() {
                self.navBarHidden = false
                self.navBarHidden = true
                UITableView.appearance().separatorColor = .clear
                self.evaluator.viewDidAppear()
            }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                self.navBarHidden = false
                self.navBarHidden = true
            }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.navBarHidden = false
                self.navBarHidden = true
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(navBarHidden)
        }
    }
}
