//
//  ConsoleIO.swift
//  Traveler
//
//  Created by David Newman on 11/14/16.
//  Copyright © 2016 orbbabluefletch. All rights reserved.
//

import Foundation

class ConsoleIO {
    class func printUsage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        print("usage:")
        print("\(executableName) -a string1 string2")
        print("or")
        print("\(executableName) -p string")
        print("or")
        print("\(executableName) -h to show usage information")
        print("Type \(executableName) without an option to enter interactive mode.")
    }
}
