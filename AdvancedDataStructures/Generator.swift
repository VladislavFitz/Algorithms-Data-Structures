//
//  Generator.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 27.09.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

extension MutableCollection {
    
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
    
}

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
