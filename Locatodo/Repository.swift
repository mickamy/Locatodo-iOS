//
//  Repository.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/21/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import RxSwift

protocol Repository: class, DataStore {
    
    associatedtype DataStoreType: DataStore
    
    var dataStore: DataStoreType { get }
    
    var models: BehaviorSubject<[ModelType]> { get }
    
    var disposeBag: DisposeBag { get }
    
}

extension Repository where DataStoreType.ModelType == Self.ModelType {
    
    private func on(event: CRUD<ModelType>) {
        var value = try! models.value()
        log.debug("on: \(event) oldValue: \(value.count)")
        switch event {
        case .create(let created):
            value.append(contentsOf: created)
            log.debug("\(created.count) item created!")
        case .read(let read):
            log.debug("\(read.count) item read!")
            return
        case .update(let updated):
            value.replace(with: updated)
            log.debug("\(updated.count) item updated!")
        case .delete(let deleted):
            value.remove(ids: deleted.map { $0.id })
            log.debug("\(deleted.count) item deleted!")
        }
        models.onNext(value)
    }
    
    func create(_ models: [Self.ModelType]) -> Observable<Void> {
        return dataStore
            .create(models)
            .do(onNext: { [weak self] _ in
                self?.on(event: .create(models))
            })
    }
    
    func find(by ids: [ModelType.ID]) -> Observable<[ModelType]> {
        return dataStore
            .find(by: ids)
            .do(onNext: { [weak self] result in
                self?.on(event: .read(result))
            })
    }
    
    func findAll() -> Observable<[ModelType]> {
        return dataStore
            .findAll()
            .do(onNext: { [weak self] result in
                self?.on(event: .read(result))
                self?.models.onNext(result)
                log.debug("READALLLLLLLLLLL")
            })
    }
    
    func update(_ models: [ModelType]) -> Observable<Void> {
        return dataStore
            .update(models)
            .do(onNext: { [weak self] _ in
                self?.on(event: .update(models))
            })
    }
    
    func delete(with ids: [ModelType.ID]) -> Observable<[ModelType]> {
        return dataStore
            .delete(with: ids)
            .do(onNext: { [weak self] deleted in
                self?.on(event: .delete(deleted))
            })
    }
    
}
