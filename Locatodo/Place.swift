//
//  Place.swift
//  Locatodo
//
//  Created by tmikami on 9/23/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import Foundation

struct Place: Model {
    
    typealias ID = String
    
    let id: String
    
    let name: String
    
    let description: String
    
    let coordinate: Coordinate
    
    let radius: Double
    
    let googleID: String?
    
    let address: String?
    
    let createdAt: TimeInterval
    
    let updatedAt: TimeInterval
    
}

extension Place {
    
    class Builder: ModelBuilder {
        
        typealias ModelType = Place
        
        var id: String?
        
        var name: String?
        
        var description: String?
        
        var coordinate: Coordinate?
        
        var radius: Double?
        
        var googleID: String?
        
        var address: String?
        
        var createdAt: TimeInterval?
        
        var updatedAt: TimeInterval?
        
        func name(_ name: String) -> Self {
            self.name = name
            return self
        }
        
        func description(_ description: String) -> Self {
            self.description = description
            return self
        }
        
        func coordinate(_ coordinate: Coordinate) -> Self {
            self.coordinate = coordinate
            return self
        }
        
        func radius(_ radius: Double) -> Self {
            self.radius = radius
            return self
        }
        
        func googleID(_ googleID: String) -> Self {
            self.googleID = googleID
            return self
        }
        
        func address(_ address: String) -> Self {
            self.address = address
            return self
        }
        
        func create() -> Place? {
            guard
                let name = name,
                let coordinate = coordinate
            else {
                log.error("name or coordinate is nil!")
                return nil
            }
            let now = currentTime()
            return Place(
                id: id ?? uuid(),
                name: name,
                description: description ?? "",
                coordinate: coordinate,
                radius: radius ?? 0,
                googleID: googleID,
                address: address,
                createdAt: createdAt ?? now,
                updatedAt: updatedAt ?? createdAt ?? now
            )
        }
        
    }
}
