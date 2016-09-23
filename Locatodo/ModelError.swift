//
//  ModelError.swift
//  Locatodo
//
//  Created by tmikami on 9/23/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

protocol ModelError {
    
    associatedtype ModelType: Model
    
    var on: CRUD<ModelType> { get }
    
    var error: Error? { get }
    
    init(on: CRUD<Self.ModelType>, error: Error?)
    
}
