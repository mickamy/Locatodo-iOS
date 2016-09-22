//
//  RealmTask.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/20/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import RealmSwift

final class RealmTask: Object {
    
    dynamic var id: String = ""
    
    dynamic var title: String = ""
    
    dynamic var completed: Bool = false
    
    dynamic var createdAt: Double = 0
    
    dynamic var updatedAt: Double = 0
    
    override static func primaryKey() -> String? {
        return ModelField.id
    }
    
}

extension RealmTask: Convertible {
    
    typealias ConvertType = Task
    
    func convert() -> Task {
        return Task(
            id: id,
            title: title,
            completed: completed,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    func copy(from original: Task) {
        id = original.id
        title = original.id
        completed = original.completed
        createdAt = original.createdAt
        updatedAt = original.updatedAt
    }
    
}

extension RealmTask {
    
    class Field: ModelField {
        
        static let title: String = "title"
        
        static let completed: String = "completed"
        
    }
}
