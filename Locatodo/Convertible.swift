//
//  Convertible.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/20/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

protocol Convertible {
    
    associatedtype ConvertType
    
    func convert() -> ConvertType
    
    func copy(from original: ConvertType)
    
}

extension Collection where Iterator.Element: Convertible {
    
    typealias ConvertType = Self.Iterator.Element.ConvertType
    
    func convert() -> [ConvertType] {
        var converted = [ConvertType]()
        for c in self {
            converted.append(c.convert())
        }
        return converted
    }
    
}
