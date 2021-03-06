//
//  Task.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/20/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

struct Task: Model {
    
    typealias ID = String
    
    let id: String
    
    let title: String
    
    var completed: Bool
    
    let createdAt: TimeInterval
    
    var updatedAt: TimeInterval
    
    mutating func complete() {
        completed = true
        updatedAt = currentTime()
    }
    
    mutating func activate() {
        completed = false
        updatedAt = currentTime()
    }
    
}

extension Task {
    
    class Builder: ModelBuilder {
        
        typealias ModelType = Task
        
        var id: String?
        
        var title: String?
        
        var completed: Bool?
        
        var createdAt: TimeInterval?
        
        var updatedAt: TimeInterval?
        
        func title(_ title: String) -> Self {
            self.title = title
            return self
        }
        
        func completed(_ completed: Bool) -> Self {
            self.completed = completed
            return self
        }
        
        func create() -> Task? {
            guard let title = title else {
                log.error("title is nil!")
                return nil
            }
            let now = currentTime()
            return Task(
                id: id ?? uuid(),
                title: title,
                completed: completed ?? false,
                createdAt: createdAt ?? now,
                updatedAt: updatedAt ?? createdAt ?? now
            )
        }
    }
}
