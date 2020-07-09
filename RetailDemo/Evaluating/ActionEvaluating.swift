//
//  ActionEvaluating.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation

/*
protocol ActionEvaluating {
    func evaluate(_ action: EvaluatorAction?)
    func _evaluate(_ action: EvaluatorAction)
}

extension ActionEvaluating {
    func evaluate(_ action: EvaluatorAction?) {
        if let action = action {
            breadcrumb(action)
            _evaluate(action)
        }
    }
    
    func breadcrumb(_ action: EvaluatorAction) {
        debugPrint("breadcrumb. evaluator: \(self) action: \(action.breadcrumbDescription)")
    }
}
 */

protocol ActionEvaluating {
    associatedtype Action: EvaluatorAction
    func evaluate(_ action: Action?)
    func _evaluate(_ action: Action)
}

extension ActionEvaluating {
    func evaluate(_ action: Action?) {
        if let action = action {
            breadcrumb(action)
            _evaluate(action)
        }
    }
    
    func breadcrumb(_ action: Action) {
        debugPrint("breadcrumb. evaluator: \(self) action: \(action.breadcrumbDescription)")
    }
}
