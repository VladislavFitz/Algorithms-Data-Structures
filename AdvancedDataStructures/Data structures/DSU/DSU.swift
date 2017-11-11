//
//  DSU.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 09.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

enum DSUError: Error {
    case AncestorNotFound
}

struct DSU {
    
    var parent = Array<Int?>.init(repeating: .none, count: 100)
    var rank = Array<Int>.init(repeating: 0, count: 100)
    
    var count: Int {
        return parent.flatMap({ $0 }).filter({ parent[$0] == $0 }).count
    }
    
    mutating func makeSet(element: Int) {
        parent[element] = element
        rank[element] = 1
    }
    
    mutating func find(element: Int) -> Int? {
        
        guard let ancestor = parent[element] else {
            return .none
        }
        
        if ancestor == element {
            return element
        }
        
        parent[element] = find(element: ancestor)
        
        return parent[element]
    }
    
    mutating func unite(elementX: Int, withElementY elementY: Int) {
        
        guard let reprX = find(element: elementX), let reprY = find(element: elementY), reprX != reprY else {
            return
        }
        
        if rank[reprX] < rank[reprY] {
            parent[reprX] = reprY
        } else {
            parent[reprY] = reprX
            
            if rank[reprX] == rank[reprY] {
                rank[reprX] = rank[reprX].advanced(by: 1)
            }
        }
        
    }
    
}
