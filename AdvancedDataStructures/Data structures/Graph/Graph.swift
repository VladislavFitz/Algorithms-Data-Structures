//
//  Graph.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 02.11.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

protocol GraphRepresentation {
    var nodesCount: Int { get }
}

protocol DirectedGraph: GraphRepresentation {
    
    func hasArc(from nodeA: Int, to nodeB: Int) -> Bool
    mutating func setArc(from nodeA: Int, to nodeB: Int)
    mutating func removeArc(from nodeA: Int, to nodeB: Int)
    
}

protocol WeightedGraph: DirectedGraph {
    
    func weightOfArc(from nodeA: Int, to nodeB: Int) -> Int
    mutating func setArc(from nodeA: Int, to nodeB: Int, withWeight weight: Int)

}


struct AdjacencyMatrix: WeightedGraph {
    
    private var matrix: Array<Array<Int>>
    
    var nodesCount: Int {
        return matrix.count
    }
    
    func neighbours(ofVertex vertex: Int) -> [Int] {
        return matrix[vertex].enumerated().filter({ $0.element != 0 }).map({ $0.offset })
    }
    
    init(nodesCount: Int) {
        self.matrix = Array<Array<Int>>(repeating: Array<Int>(repeating: 0, count: nodesCount), count: nodesCount)
    }
    
    func hasArc(from nodeA: Int, to nodeB: Int) -> Bool {
        return matrix[nodeA][nodeB] > 0
    }
    
    mutating func setArc(from nodeA: Int, to nodeB: Int) {
        matrix[nodeA][nodeB] = 1
        matrix[nodeB][nodeA] = 1
    }
    
    mutating func removeArc(from nodeA: Int, to nodeB: Int) {
        matrix[nodeA][nodeB] = 0
        matrix[nodeB][nodeA] = 0
    }
    
    func weightOfArc(from nodeA: Int, to nodeB: Int) -> Int {
        return matrix[nodeA][nodeB]
    }
    
    mutating func setArc(from nodeA: Int, to nodeB: Int, withWeight weight: Int) {
        matrix[nodeA][nodeB] = weight
        matrix[nodeB][nodeA] = weight
    }
    
    subscript(key: Int) -> [Int] {
        return matrix[key]
    }
    
}

struct AdjacencyList: GraphRepresentation {
    
    private var list: [Set<Int>]
    
    var nodesCount: Int {
        return list.count
    }
    
    init(nodesCount: Int) {
        self.list = Array(repeating: [], count: nodesCount)
    }
    
    func hasArc(between nodeA: Int, and nodeB: Int) -> Bool {
        return list[nodeA].contains(nodeB)
    }
    
    mutating func setArc(between nodeA: Int, and nodeB: Int) {
        list[nodeA].insert(nodeB)
        list[nodeB].insert(nodeA)
    }
    
    mutating func removeArc(between nodeA: Int, and nodeB: Int) {
        list[nodeA].remove(nodeB)
        list[nodeB].remove(nodeA)
    }
    
}
