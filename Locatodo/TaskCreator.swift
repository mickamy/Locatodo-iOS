//
//  TaskCreator.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/22/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

final class TaskCreator {
    
    static func dummy(size: Int) -> [Task] {
        var dummy: [Task] = []
        for i in 0..<size {
            if let task = task(index: i) {
                dummy.append(task)
            }
        }
        return dummy
    }
    
    private static func task(index i: Int) -> Task? {
        return Task.Builder()
            .title("Task \(i)")
            .create()
    }
}
