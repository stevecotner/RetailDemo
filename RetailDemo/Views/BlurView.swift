//
//  BlurView.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

/// Caution: I haven't yet found a way to disable user interaction on this blur view. "isUserInteractionEnabled,", even when applied to all subviews, seems to have no effect.
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemThinMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
