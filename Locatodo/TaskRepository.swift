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
    
    typealias ModelErrorType = TaskModelError
    
    static let instance = TaskRepository()
    
    let dataStore: TaskDataStore = TaskDataStore.instance
    
    let models: BehaviorSubject<[Task]> = BehaviorSubject(value: [])
    
    let error: BehaviorSubject<TaskModelError?> = BehaviorSubject(value: nil)
    
    let disposeBag: DisposeBag = DisposeBag()
    
    private init() {
        findAll()
            .subscribe(
                onNext: { [weak self] values in
                    self?.models.onNext(values) })
            .addDisposableTo(disposeBag)
    }
}
