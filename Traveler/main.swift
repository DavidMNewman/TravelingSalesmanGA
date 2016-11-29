//
//  main.swift
//  Traveler
//
//  Created by David Newman on 11/11/16.
//  Copyright © 2016 orbbabluefletch. All rights reserved.
//

import Foundation

print("Starting up!")

ConsoleIO.printUsage()

let tour = Tour(mock: true)

do {
    var population = try Population(startingCity: tour.startingCity, cities: tour.cities, populationCount: 100)
    
    print("Fittest: \(population.getFittest()?.distance)\n   \(population.getFittest())")
    TravellingSalesmanAlgorithm.evolvePopulation(population: &population, generations: 10)
    
    print("evolved!")
    print("Fittest: \(population.getFittest()?.distance)\n   \(population.getFittest())")
} catch { error
    print("Failed to create population, error: \(error)")
}
