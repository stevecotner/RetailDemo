//
//  ImageExtensions.swift
//  RetailDemo
//
//  Created by Stephen E. Cotner on 6/28/20.
//

import SwiftUI

extension Image {
    static func numberCircleFill(_ int: Int) -> Image {
        let systemName = (int <= 50) ? "\(int).circle.fill" : "circle.fill"
        return Image(systemName: systemName)
    }
    
    static func numberCircle(_ int: Int) -> Image {
        let systemName = (int <= 50) ? "\(int).circle" : "circle"
        return Image(systemName: systemName)
    }
}
