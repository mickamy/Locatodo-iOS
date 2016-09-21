//
//  TaskDataStore.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/21/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

final class TaskDataStore: RealmDataSource {
    
    typealias ModelType = Task
    
    typealias RealmObject = RealmTask
    
    static let instance = TaskDataStore()
    
    private init() {}
}
