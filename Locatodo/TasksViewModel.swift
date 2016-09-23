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
    
    private let bag: DisposeBag = DisposeBag()
    
    private let tasksVariable: Variable<[Task]> = Variable([])
    
    private let errorVariable: Variable<TaskModelError?> = Variable(nil)
    
    public let tasks: Observable<[Task]>
    
    public let error: Observable<TaskModelError?>
    
    init() {
        TaskRepository.instance
            .models
            .shareReplay(1)
            .bindTo(tasksVariable)
            .addDisposableTo(bag)
        
        TaskRepository.instance
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
    
    public func create(tasks: [Task]) {
        TaskRepository.instance
            .create(tasks)
            .subscribe { event in
                switch event {
                case .next(_):
                    log.debug("next created : \(tasks.count) items")
                case .error(let e):
                    log.error("error on create: \(e.localizedDescription)")
                case .completed:
                    log.debug("completed")
                }
            }.addDisposableTo(bag)
    }
    
}
