//
//  Array+Convenience.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 02.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {
    
    var isSorted: Bool {
        
        if isEmpty { return true }
        
        for index in 1..<self.endIndex {
            if self[index-1] > self[index] {
                return false
            }
        }
        
        return true
        
    }
    
}
