//
//  DemoControlPanelView.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

struct DemoControlPanelView: View {
    let controls: [DemoControl]
    
    init(_ controls: [DemoControl]) {
        self.controls = controls
    }
    
    var body: some View {
        VStack(spacing: 7) {
            if !controls.isEmpty {
                HStack {
                    Spacer().frame(width: 50)
                    
                    Text("Settings")
                        .font(Font.headline)
                        
                        .foregroundColor(Color.primary.opacity(0.95))
                    Spacer()
                }
            }
            
            Spacer().frame(height: 7)
            
            ForEach(controls, id: \.id) { control in
                
                VStack {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer().frame(width: 50)
                            Text(control.title)
                                .font(Font.caption.bold())
                                .foregroundColor(Color.primary.opacity(0.9))
                            Spacer()
                        }

                        if control.instruction != nil {
                            Spacer().frame(height: 6)
                            HStack {
                                Spacer().frame(width: 50)
                                Text(control.instruction!)
                                    .font(Font.caption)
                                    .foregroundColor(Color.primary.opacity(0.43))
                                Spacer().frame(width: 50)
                                Spacer()
                            }
                        }
                    }

                    Spacer().frame(height: 10)
                    control.view
                    Spacer().frame(height: 16)
                }
            }
        }
    }
}
