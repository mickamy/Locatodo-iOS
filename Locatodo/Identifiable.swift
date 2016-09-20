//
//  Identifiable.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/20/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

protocol Identifiable {
    
    associatedtype ID: Equatable
    
    var id: ID { get }
    
}

extension Identifiable where Self.ID == String {
    
    static var uuid: String {
        return NSUUID().uuidString
    }
    
}

extension Collection where Iterator.Element: Identifiable {
    
    func indexOf(id: Self.Iterator.Element.ID) -> Self.Index? {
        return self.index(where: { $0.id == id })
    }
    
    func indexOf(_ element: Self.Iterator.Element) -> Self.Index? {
        return indexOf(id: element.id)
    }
    
}

extension MutableCollection where Iterator.Element: Identifiable {
    
    mutating func replace(with newElement: Self.Iterator.Element) {
        if let i = indexOf(id: newElement.id) {
            self[i] = newElement
        }
    }
    
    mutating func replace(with newElements: [Self.Iterator.Element]) {
        for element in newElements {
            replace(with: element)
        }
    }
    
}

extension Array where Element: Identifiable {
    
    mutating func remove(ids: [Element.ID]) {
        self = self.filter { !(ids.contains($0.id)) }
    }
    
}
