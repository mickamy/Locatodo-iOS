//
//  DataStore.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/20/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import RxSwift

protocol DataStore {
    
    associatedtype ModelType: Model
    
    func create(_ models: [ModelType]) -> Observable<Void>
    
    func find(by ids: [ModelType.ID]) -> Observable<[ModelType]>
    
    func findAll() -> Observable<[ModelType]>
    
    func update(_ models: [ModelType]) -> Observable<Void>
    
    func delete(with ids: [ModelType.ID]) -> Observable<[ModelType]>
    
}

extension DataStore {
    
    var disposable: Disposable {
        return Disposables.create()
    }
    
}
