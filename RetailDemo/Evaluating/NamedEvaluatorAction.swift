//
//  NamedEvaluatorAction.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation

struct NamedEvaluatorAction {
    let name: String
    let action: EvaluatorAction
    var id: UUID = UUID()
}

/*
struct NumberedNamedEvaluatorAction {
   let number: Int
   let name: String
   let action: EvaluatorAction
   var id: UUID = UUID()
}

struct NamedEnabledEvaluatorAction {
   let name: String
   let enabled: Bool
   let action: EvaluatorAction
   var id: UUID = UUID()
}
*/

struct NumberedNamedEvaluatorAction<A: EvaluatorAction> {
    let number: Int
    let name: String
    let action: A
    var id: UUID = UUID()
}

struct NamedEnabledEvaluatorAction<A: EvaluatorAction> {
    let name: String
    let enabled: Bool
    let action: A
    var id: UUID = UUID()
}
 
