//
//  TasksViewModel.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/22/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import RxSwift
import RxCocoa

final class TasksViewModel {
    
    private let repository: TaskRepository
    
    private let bag: DisposeBag = DisposeBag()
    
    private let tasksVariable: Variable<[Task]> = Variable([])
    
    private let errorVariable: Variable<TaskModelError?> = Variable(nil)
    
    public let tasks: Observable<[Task]>
    
    public let error: Observable<TaskModelError?>
    
    init(_ repository: TaskRepository) {
        self.repository = repository
        
        self.repository
            .models
            .shareReplay(1)
            .bindTo(tasksVariable)
            .addDisposableTo(bag)
        
        self.repository
            .error
            .shareReplay(1)
            .bindTo(errorVariable)
            .addDisposableTo(bag)
        
        self.tasks = tasksVariable
            .asObservable()
            .shareReplay(1)
        
        self.error = errorVariable
            .asObservable()
            .shareReplay(1)
    }
    
}
