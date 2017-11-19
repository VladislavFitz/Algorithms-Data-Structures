//
//  FirstBadVersion.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 19/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

class FirstBadVersion: Algorithm {
    
    typealias Input = Int
    typealias Output = Int
    
    let input: Input
    let firstBadVersion: Int
    var output: Int = -1
    
    init(input: Input, firstBadVersion: Int) {
        self.input = input
        self.firstBadVersion = firstBadVersion
    }

    func perform() {
        
        func firstBadVersion(from: Int, to: Int) -> Int {
            
            if isBadVersion(from) {
                return from
            }
            
            let middleVersion = from + (to-from)/2
            
            if isBadVersion(middleVersion) {
                return firstBadVersion(from: from, to: middleVersion)
            } else {
                return firstBadVersion(from: middleVersion+1, to: to)
            }
            
        }
        
        output = firstBadVersion(from: 1, to: input)
        
    }
    
    func isBadVersion(_ version: Int) -> Bool {
        return version >= firstBadVersion
    }
    
}
