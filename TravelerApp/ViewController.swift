//
//  ViewController.swift
//  TravelerApp
//
//  Created by David Newman on 11/28/16.
//  Copyright © 2016 orbbabluefletch. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let tour = Tour(mock: true)
    var population: Population?
    var basicFittest: Tour?
    var timeSpentCalculating: Double = Double(0)
    
    var generations = 25
 
    @IBOutlet weak var generationsField: NSTextField!
    
    
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            population = try Population(startingCity: tour.startingCity, cities: tour.cities, populationCount: 100)
            
            basicFittest = TravellingSalesmanAlgorithm.basicFindShortest(startingCity: (tour.startingCity), cities: (tour.cities))
            
            print("Fittest: \(population!.getFittest())\n  Basic Algorithm \(basicFittest)")
        } catch { error
            print("Failed to create population, error: \(error.localizedDescription)")
        }
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func calculate(_ sender: Any) {
        
//        guard let generations = generationsField.integerValue else {
//            return
//        }

        let generations = generationsField.integerValue
        
        let startTime = CFAbsoluteTimeGetCurrent()
        
        TravellingSalesmanAlgorithm.evolvePopulation(population: &population!, generations: generations)
        
        print("evolved!")
        guard let fittest = population?.getFittest() else {
            return
        }
        
        guard let basicFittest = basicFittest else {
            return
        }
        
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime

        timeSpentCalculating+=timeElapsed
        
        let output = "After \(generations) Generations\nImprovement: \((basicFittest.distance/fittest.distance) * 100 - 100)%\nTime: \(timeElapsed) seconds\nTour \(fittest)"
        
        print(output)
        print("Total Time: \(timeSpentCalculating)")
        
        textField.stringValue = output
    }
}

