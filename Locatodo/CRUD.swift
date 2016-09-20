//
//  CRUD.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/20/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

enum CRUD<ModelType: Model> {
    
    case create([ModelType])
    case read
    case update([ModelType])
    case delete([ModelType])
    
}
