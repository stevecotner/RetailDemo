//
//  Observer.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

struct Observer<Content, A>: View where Content: View {
    @ObservedObject var observable: ObservableObjectWrapper<A>
    var content: (A) -> Content
    
    init(_ observable: ObservableObjectWrapper<A>, @ViewBuilder content: @escaping (A) -> Content) {
        self.observable = observable
        self.content = content
    }
    
    var body: some View {
        content(observable.value)
    }
}

struct Observer2<Content, A, B>: View where Content: View {
    @ObservedObject var observableA: ObservableObjectWrapper<A>
    @ObservedObject var observableB: ObservableObjectWrapper<B>
    var content: (A, B) -> Content
    
    init(_ observableA: ObservableObjectWrapper<A>, _ observableB: ObservableObjectWrapper<B>, @ViewBuilder content: @escaping (A, B) -> Content) {
        self.observableA = observableA
        self.observableB = observableB
        self.content = content
    }
    
    var body: some View {
        content(observableA.value, observableB.value)
    }
}

struct Observer3<Content, A, B, C>: View where Content: View {
    @ObservedObject var observableA: ObservableObjectWrapper<A>
    @ObservedObject var observableB: ObservableObjectWrapper<B>
    @ObservedObject var observableC: ObservableObjectWrapper<C>
    var content: (A, B, C) -> Content
    
    init(_ observableA: ObservableObjectWrapper<A>, _ observableB: ObservableObjectWrapper<B>, _ observableC: ObservableObjectWrapper<C>, @ViewBuilder content: @escaping (A, B, C) -> Content) {
        self.observableA = observableA
        self.observableB = observableB
        self.observableC = observableC
        self.content = content
    }
    
    var body: some View {
        content(observableA.value, observableB.value, observableC.value)
    }
}
