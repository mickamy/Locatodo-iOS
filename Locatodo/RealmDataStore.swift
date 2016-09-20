//
//  RealmDataStore.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/20/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import RxSwift
import RealmSwift

protocol RealmDataSource: class, DataStore {
    
    associatedtype RealmObject: Object
    
}

extension RealmDataSource
    where RealmObject: Convertible,
          RealmObject.ConvertType == Self.ModelType {
    
    func create(_ models: [Self.ModelType]) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let weakself = self else {
                return Disposables.create()
            }
            let realm = try! Realm()
            do {
                try realm.write {
                    realm.add(weakself.realmObjects(from: models))
                }
            } catch(let e) {
                log.error(e)
                observer.onError(e)
            }
            observer.onNext(Void())
            observer.onCompleted()
            return weakself.disposable
        }
    }
    
    func find(by ids: [Self.ModelType.ID]) -> Observable<[Self.ModelType]> {
        return Observable.create { [weak self] observer in
            guard let weakself = self else {
                return Disposables.create()
            }
            let realm = try! Realm()
            let results = weakself.find(realm, by: ids)
            observer.onNext(results.convert())
            observer.onCompleted()
            return weakself.disposable
        }
    }
    
    private func realmObjects(from models: [Self.ModelType]) -> [Self.RealmObject] {
        var objects = [RealmObject]()
        for model in models {
            let object = RealmObject()
            object.copy(from: model)
            objects.append(object)
        }
        return objects
    }
    
    private func find(_ realm: Realm, by ids: [Self.ModelType.ID]) -> Results<Self.RealmObject> {
        return realm.objects(RealmObject.self)
            .filter("\(RealmObject.primaryKey()!) IN %@", ids)
    }
}
