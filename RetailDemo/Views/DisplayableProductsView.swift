//
//  DisplayableProductsView.swift
//  Poet
//
//  Created by Stephen E. Cotner on 5/21/20.
//  Copyright © 2020 Steve Cotner. All rights reserved.
//

import SwiftUI

protocol ActionEvaluating_ProductFinding: ActionEvaluating where Action: EvaluatorAction_ProductFinding {}
        
protocol EvaluatorAction_ProductFinding: EvaluatorAction {
    static func toggleProductFound(_ product: FindableProduct) -> Self
    static func toggleProductNotFound(_ product: FindableProduct) -> Self
}

struct DisplayableProductsView<E: ActionEvaluating_ProductFinding>: View {
    @Observed var displayableProducts: [DisplayableProduct]
    let evaluator: E
    
    var body: some View {
        return VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 40) {
                ForEach(displayableProducts, id: \.id) { displayableProduct in
                    return HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            ProductView(product: displayableProduct.product)
                            if displayableProduct.findableProduct != nil {
                                FoundNotFoundButtonsView(findableProduct: displayableProduct.findableProduct!, evaluator: self.evaluator)
                                    .padding(EdgeInsets(top: 8, leading: 20, bottom: 0, trailing: 20))
                                    .transition(.opacity)
                            }
                        }
                    }
                }
            }
            
            Spacer().frame(height: 30)
        }
    }
}

// MARK: View Demoing

extension DisplayableProductsView: ViewDemoing {
    static var demoProvider: DemoProvider { return DisplayableProductsView_DemoProvider() }
}

struct DisplayableProductsView_DemoProvider: DemoProvider, ActionEvaluating_ProductFinding {
    
    @ObservedObject @Observable var displayableProducts: [DisplayableProduct] = [
        DisplayableProduct(
            product: Product(
                title: "Air Jordan 1 Mid",
                upc: "123678098543",
                image: "airJordan1Mid-red",
                location: "Bin 1"),
            findableProduct: nil),
        
        DisplayableProduct(
        product: Product(
            title: "Air Jordan 1 Mid",
            upc: "2468098753120",
            image: "airJordan1Mid-green",
            location: "Bin 2"),
        findableProduct: nil),
        
        DisplayableProduct(
        product: Product(
            title: "Air Jordan 1 Mid",
            upc: "642798530951",
            image: "airJordan1Mid-blue",
            location: "Bin 3"),
        findableProduct: nil)
    ]
    
    func deepCopy() -> Self {
        let provider = DisplayableProductsView_DemoProvider(
            displayableProducts: self.$displayableProducts.wrappedValue.wrappedValue
        )
        return provider
    }
    
    var contentView: AnyView {
        return AnyView(
            DisplayableProductsView(
                displayableProducts: _displayableProducts.wrappedValue.projectedValue,
                evaluator: self)
        )
    }
    
    var controls: [DemoControl] {
        return [
            /*
            DemoControl(
                title: "Number of products",
                instructions: "Type a positive number.") {
                    AnyView(
                        //
                    )
            }
             */
        ]
    }
    
    enum Action: EvaluatorAction_ProductFinding {
        case toggleProductFound(_ product: FindableProduct)
        case toggleProductNotFound(_ product: FindableProduct)
    }
    
    func _evaluate(_ action: Action) {
        switch action {
        case .toggleProductFound(let product):
            debugPrint("toggle product found: \(product)")
        case .toggleProductNotFound(let product):
            debugPrint("toggle product not found: \(product)")
        }
    }
}
