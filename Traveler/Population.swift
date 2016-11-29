//
//  Population.swift
//  Traveler
//
//  Created by David Newman on 11/14/16.
//  Copyright © 2016 orbbabluefletch. All rights reserved.
//

import Foundation

struct Population {
    
    var tours = [Tour]()
    
    init() {
    }
    
    init(startingCity: City, cities: [City], populationCount: Int) throws {
        
        guard (populationCount%2) == 0 else {
            throw AlgorithmError.populationMustBeEven
        }
        
        for _ in 0...populationCount {
            tours.append(Tour(startingCity: startingCity, cities: cities.shuffle()))
        }
    }
}

extension Population {
    
    func getFittest() -> Tour? {
        return self.tours.min(by: { (tour1, tour2) -> Bool in
            return tour1.distance < tour2.distance
        })
    }
    
    func getOrderedByFittest() -> [Tour] {
        return tours.sorted { (tour1, tour2) -> Bool in
            tour1.distance < tour2.distance
        }
    }
}
