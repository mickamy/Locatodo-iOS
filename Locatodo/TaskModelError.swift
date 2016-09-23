//
//  TaskModelError.swift
//  Locatodo
//
//  Created by tmikami on 9/23/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

struct TaskModelError: ModelError {
    
    typealias ModelType = Task
    
    let on: CRUD<Task>
    
    let error: Error?
    
}
