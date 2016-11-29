//
// Created by David Newman on 11/11/16.
// Copyright (c) 2016 bluefletch. All rights reserved.
//

import Foundation
import CoreLocation

struct City: CustomStringConvertible {

    let name: String
    var description: String {
        return "\(name): (\(location.coordinate.latitude), \(location.coordinate.longitude))\n"
    }
    let location: CLLocation

    var hashValue: Int

    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.location = CLLocation(latitude:latitude, longitude: longitude)
        self.hashValue = location.hashValue
    }
}

extension City {

    func distanceTo(city: City) -> Double {

        let x = self.location.coordinate.longitude - city.location.coordinate.longitude
        let y = self.location.coordinate.latitude - city.location.coordinate.latitude

        let distance = sqrt( (x*x) + (y*y))

        return distance
    }
}

extension City: Equatable {
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
