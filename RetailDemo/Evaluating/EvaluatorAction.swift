//
//  EvaluatorAction.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import Foundation

protocol EvaluatorAction {
    var breadcrumbDescription: String { get }
}

extension EvaluatorAction {
    var breadcrumbDescription: String {
        return String(describing: self)
    }
}
