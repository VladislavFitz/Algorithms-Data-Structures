//
//  MutableCollection+Shuffle.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 11/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
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
    
    func shuffled() -> Self {
        var collection = self
        collection.shuffle()
        return collection
    }
    
}
