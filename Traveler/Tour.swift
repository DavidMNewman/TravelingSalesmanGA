//
// Created by David Newman on 11/11/16.
// Copyright (c) 2016 orbbabluefletch. All rights reserved.
//

import Foundation


class Tour: CustomStringConvertible {

    var startingCity: City
    var cities = [City]()
    var description: String  {
        return "Distance: \(self.distance)\n    \(cities)"
    }
    
    var fitness: Double {
        return 1.0/self.distance
    }
    
    lazy var distance: Double = {
        guard let nextCity = self.cities.first else {
            return Double(NSIntegerMax)
        }
        
        var result = self.startingCity.distanceTo(city: nextCity)
        
        for i in 0..<self.cities.count - 1 {
            result+=self.cities[i].distanceTo(city:self.cities[i+1])
        }
        
        if let returnTrip = self.cities.last?.distanceTo(city: self.startingCity) {
            result+=returnTrip
        }
        
        result*=111
        
        return Double(result)
    }()
    
    init(startingCity: City, cities: [City]) {
        
        self.startingCity = startingCity
        self.cities = cities
    }
    
    convenience init(mock: Bool=true) {
        var cities = [City]()
        
        cities.append(City(name:"Boston", latitude: 42, longitude: -71))
        cities.append(City(name:"Buffalo", latitude: 42, longitude: -78))
        cities.append(City(name:"Charlotte", latitude: 35, longitude: -80))
        cities.append(City(name:"Cleveland", latitude: 41, longitude: -81))
        cities.append(City(name:"Dallas", latitude: 32, longitude: -96))
        cities.append(City(name:"Fargo", latitude: 46, longitude: -96))
        cities.append(City(name:"Denver", latitude: 39, longitude: -105))
        cities.append(City(name:"Fresno", latitude: 36, longitude: -119))
        cities.append(City(name:"Jacksonville", latitude: 30, longitude: -81))
        cities.append(City(name:"Las Vegas", latitude: 36, longitude: -115))
        cities.append(City(name:"Los Angeles", latitude: 34, longitude: -118))
        cities.append(City(name:"Minneapolis", latitude: 44, longitude: -93))
        cities.append(City(name:"New York", latitude: 40, longitude: -73))
        cities.append(City(name:"Quebec", latitude: 46, longitude: -71))
        cities.append(City(name:"Salt Lake City", latitude: 40, longitude: -111))
        cities.append(City(name:"San Francisco", latitude: 37, longitude: -122))
        cities.append(City(name:"Toronto", latitude: 43, longitude: -40))
        cities.append(City(name:"Vancouver", latitude: 49, longitude: -123))
        cities.append(City(name:"Washington D.C.", latitude: 38, longitude: -77))
        cities.append(City(name:"Wichita", latitude: 37, longitude: -97))
        cities.append(City(name:"London", latitude: 51, longitude: 0))
        cities.append(City(name:"Paris", latitude: 49, longitude: 2))
        cities.append(City(name:"Berlin", latitude: 52, longitude: 13))
        cities.append(City(name:"Moscow", latitude: 56, longitude: 38))
        cities.append(City(name:"Rio", latitude: -23, longitude: -43))
        cities.append(City(name:"Mexico City", latitude: -24, longitude: -103))

        cities = cities.shuffle()
        
        self.init(startingCity: City(name:"Atlanta", latitude: 33, longitude: -84), cities: cities)

        

    }
}

extension Tour {
    
    
    
    func populate() {
        var cities = [City]()
        
        cities.append(City(name:"Boston", latitude: 42, longitude: 71))
        cities.append(City(name:"Buffalo", latitude: 42, longitude: 78))
        cities.append(City(name:"Charlotte", latitude: 35, longitude: 80))
        cities.append(City(name:"Cleveland", latitude: 41, longitude: 81))
        cities.append(City(name:"Dallas", latitude: 32, longitude: 96))
        cities.append(City(name:"Fargo", latitude: 46, longitude: 96))
        cities.append(City(name:"Denver", latitude: 39, longitude: 105))
        cities.append(City(name:"Fresno", latitude: 36, longitude: 119))
        cities.append(City(name:"Jacksonville", latitude: 30, longitude: 81))
        cities.append(City(name:"Las Vegas", latitude: 36, longitude: 115))
        cities.append(City(name:"Los Angeles", latitude: 34, longitude: 118))
        cities.append(City(name:"Minneapolis", latitude: 44, longitude: 93))
        cities.append(City(name:"New York", latitude: 40, longitude: 73))
        cities.append(City(name:"Quebec", latitude: 46, longitude: 71))
        cities.append(City(name:"Salt Lake City", latitude: 40, longitude: 111))
        cities.append(City(name:"San Francisco", latitude: 37, longitude: 122))
        cities.append(City(name:"Toronto", latitude: 43, longitude: 40))
        cities.append(City(name:"Vancouver", latitude: 49, longitude: 123))
        cities.append(City(name:"Washington D.C.", latitude: 38, longitude: 77))
        cities.append(City(name:"Wichita", latitude: 37, longitude: 97))
        
        self.cities = cities.shuffle()
    }
}
