//
//  Model.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/20/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

protocol Model: Identifiable {
    
    var createdAt: TimeInterval { get }
    
    var updatedAt: TimeInterval { get }
    
}

extension Model {
    
    func currentTime() -> TimeInterval {
        return NSDate().timeIntervalSince1970
    }
    
}

protocol ModelBuilder {
    
    associatedtype ModelType: Model
    
    var id: ModelType.ID? { get set }
    
    var createdAt: TimeInterval? { get set }
    
    var updatedAt: TimeInterval? { get set }
    
    func create() -> ModelType?
    
}

extension ModelBuilder {
    
    func currentTime() -> TimeInterval {
        return NSDate().timeIntervalSince1970
    }
    
    mutating func id(_ id: Self.ModelType.ID) -> Self {
        self.id = id
        return self
    }
    
    mutating func createdAt(_ createdAt: TimeInterval) -> Self {
        self.createdAt = createdAt
        return self
    }
    
    mutating func updatedAt(_ updatedAt: TimeInterval) -> Self {
        self.updatedAt = updatedAt
        return self
    }
    
}

extension ModelBuilder where ModelType.ID == String {
    
    func uuid() -> String {
        return NSUUID().uuidString
    }
    
}
