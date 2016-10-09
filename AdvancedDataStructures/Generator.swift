//
//  Generator.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 27.09.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

struct Generator {
    
    var generatedElements: Set<Int> = []
    var leftElements: Set<Int>
    
    init(bound: Int) {
        self.leftElements = []
        for i in 0..<bound {
            leftElements.insert(i)
        }
    }
    
    mutating func getNewValue() -> Int {
        let leftElementsArray = Array(leftElements)
        let elementToExtractIndex = Int(arc4random_uniform(UInt32(leftElements.count)))
        let elementToExtract = leftElementsArray[elementToExtractIndex]
        generatedElements.insert(elementToExtract)
        return leftElements.remove(elementToExtract)!
    }
    
}
