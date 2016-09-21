//
//  TaskRepository.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/21/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import RxSwift

final class TaskRepository: Repository {
    
    typealias ModelType = Task
    
    typealias DataStoreType = TaskDataStore
    
    static let instance = TaskRepository()
    
    let dataStore: TaskDataStore = TaskDataStore.instance
    
    let models: BehaviorSubject<[Task]> = BehaviorSubject(value: [])
    
    private init() {
    }
}
