//
//  TravellingSalesmanAlgorithm.swift
//  Traveler
//
//  Created by David Newman on 11/14/16.
//  Copyright © 2016 orbbabluefletch. All rights reserved.
//

import Foundation

enum AlgorithmError: Error {
    case populationMustBeEven
}

struct TravellingSalesmanAlgorithm {

    static fileprivate let mutationRate = 0.015
    static fileprivate let tournamentSize = 10
    static fileprivate let topCandiatesSaved = 2


    static func basicFindShortest(startingCity: City, cities: [City]) -> Tour {

        var currentCity = startingCity
        var result = [City]()

        let sortedBy = { (city1, city2) -> Bool in
            currentCity.distanceTo(city: city1) < currentCity.distanceTo(city: city2)
        }

        var sortedCities = cities.sorted(by: sortedBy)

        for _ in 1 ..< cities.count {

            sortedCities = sortedCities.sorted(by: sortedBy)

            guard let closestCity = sortedCities.first else {
                continue
            }

            currentCity = closestCity
            result.append(currentCity)
            sortedCities.removeFirst()
        }


        return Tour(startingCity: startingCity, cities: result)
    }

    static func evolvePopulation(population: inout Population, generations: Int = 1) {
        
        let tour = population.getFittest()
        
        let basicFittest = TravellingSalesmanAlgorithm.basicFindShortest(startingCity: (tour?.startingCity)!, cities: (tour?.cities)!)
        population.tours.append(basicFittest)
        population.tours.append(basicFittest)
        
        for _ in 0...generations {
         
            if topCandiatesSaved > 0 {
                let sortedTours = population.getOrderedByFittest()
                for i in 0..<topCandiatesSaved {
                    population.tours[i] = sortedTours[i]
                }
            }
            
            // First we create new children using crossover
            for i in topCandiatesSaved ..< population.tours.count {
                
                guard let parent1 = tournamentSelection(population: population) else {
                    continue
                }
                
                guard let parent2 = tournamentSelection(population: population) else {
                    continue
                }
                
                let child = crossover(parent1: parent1, parent2: parent2)
                
                // Add the child to the new population
                population.tours[i] = child
            }
            
            // Second, we mutate the children
            
            for i in topCandiatesSaved..<population.tours.count {
                mutate(tour: &population.tours[i])
            }
        }
    }

    fileprivate static func crossover(parent1: Tour, parent2: Tour) -> Tour {

        let childSize = parent1.cities.count
        var childCities = [City?](repeating: nil, count: childSize)

        let startIndex = Int.random(n: parent1.cities.count)
        let endIndex = Int.random(n: parent2.cities.count)

        // Loop and add the sub tour from parent1 to our child
        for i in 0..<parent1.cities.count {

            // If our start position is less than the end position
            if (startIndex < endIndex && i > startIndex && i < endIndex) {
                childCities[i] = parent1.cities[i]

            } else if (startIndex > endIndex) {
                // If our start position is larger
                if (!(i < startIndex && i > endIndex)) {
                    childCities[i] = parent1.cities[i]
                }
            }
        }
        
        // Loop through parent2's city tour
        for parentCity in parent2.cities {
            
            if !childCities.contains(where: { $0 == parentCity }) {
                // Loop to find a spare position in the child's tour
                for i in 0..<childCities.count {
                    // Spare position found, add city
                    if childCities[i] != nil {
                        continue
                    }
                    
                    childCities[i] = parentCity
                    
                    break
                }
            }
        }
        
        let tour = Tour(startingCity: parent1.startingCity, cities: childCities.flatMap { $0 })
        
        return tour
    }

    
    fileprivate static func mutate(tour: inout Tour) {
        
        for index1 in 0..<tour.cities.count {
            // Apply mutation rate
            let rate = Double(arc4random_uniform(100))/100.0
            if (rate < mutationRate) {
                
                // Get a second random position in the tour
                let index2 = Int.random(n: tour.cities.count)
                
                // Get the cities at target position in tour
                let city1 = tour.cities[index1]
                let city2 = tour.cities[index2]
                
                // Swap the 2 cities
                tour.cities[index1] = city2
                tour.cities[index2] = city1
            }
        }
        
    }
    
    fileprivate static func tournamentSelection(population: Population) -> Tour? {

        precondition(population.tours.count > 0)

        var tournament = Population()

        for _ in 0 ..< tournamentSize {
            let random = population.tours[Int(arc4random_uniform(UInt32(population.tours.count)))]
            tournament.tours.append(random)
        }

        let tour = tournament.getFittest()
        
        return tour
    }
}



