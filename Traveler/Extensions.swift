//
//  Extensions.swift
//  Traveler
//
//  Created by David Newman on 11/14/16.
//  Copyright © 2016 orbbabluefletch. All rights reserved.
//

import Foundation

extension Int {
    
    /**
     * Returns a random integer between 0 and n-1.
     */
    public static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    /**
     * Returns a random integer in the range min...max, inclusive.
     */
    public static func random(min: Int, max: Int) -> Int {
        assert(min < max)
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        let num = count as! Int
        
        for i in 0..<num {
            let j = Int(arc4random_uniform(UInt32(num - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
