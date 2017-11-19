//
//  DijkstraAlgorithm.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 19/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

class DijkstraAlgorithm: Algorithm {
    
    typealias Input = AdjacencyMatrix
    typealias Output = [Int: Int]
    
    var input: AdjacencyMatrix {
        return graph
    }
    
    var output: [Int : Int] {
        return paths
    }
    
    let graph: AdjacencyMatrix
    let fromVertex: Int
    private var visitedVertexes: Set<Int>
    private var paths: [Int: Int]
    
    init(graph: AdjacencyMatrix, fromVertex: Int) {
        assert(fromVertex < graph.nodesCount)
        self.graph = graph
        self.fromVertex = fromVertex
        self.visitedVertexes = []
        self.paths = [:]
        
        for element in 0..<graph.nodesCount {
            paths[element] = .max
        }
        paths[fromVertex] = 0
        
    }
    
    func perform() {
        
        var currentVertex = fromVertex
        
        while visitedVertexes.count != graph.nodesCount {
            
            var nearestNeighbour = (index: currentVertex, weight: Int.max)
            
            for (neighbour, weight) in graph[currentVertex].enumerated() where weight != 0 && !visitedVertexes.contains(neighbour) {
                
                if paths[currentVertex]! + weight < paths[neighbour]! {
                    paths[neighbour] = paths[currentVertex]! + weight
                }
                
                if weight < nearestNeighbour.weight  {
                    nearestNeighbour = (index: neighbour, weight: weight)
                }
                
            }
            
            visitedVertexes.insert(currentVertex)
            currentVertex = nearestNeighbour.index
            
        }
        
    }
    
}
