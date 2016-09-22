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
    
    private let tasksVariable: Variable<[Task]> = Variable<[Task]>([])
    
    public let tasks: Observable<[Task]>
    
    init(_ repository: TaskRepository) {
        self.repository = repository
//        self.tasksVariable =
        self.repository
            .models
            .bindTo(tasksVariable)
            .addDisposableTo(bag)
        self.tasks = tasksVariable.asObservable()
    }
    
}
