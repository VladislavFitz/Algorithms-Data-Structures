//
//  BFS.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 21.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct BreadthFirstSearch: Algorithm {
        
    typealias Input = (graph: AdjacencyMatrix, startVertex: Int)
    typealias Output = [Int]
    
    let graph: AdjacencyMatrix
    let startVertex: Int
    var visitedVertexes: [Int] = []
    
    var input: (graph: AdjacencyMatrix, startVertex: Int) {
        return (graph: self.graph, startVertex: self.startVertex)
    }
    
    var output: [Int] {
        return visitedVertexes
    }
    
    private var vertexQueue: [Int] = []
    
    init(graph: AdjacencyMatrix, startVertex: Int) {
        self.graph = graph
        self.startVertex = startVertex
    }

    mutating func perform() {
        
        vertexQueue.append(startVertex)
        
        while let currentVertex = vertexQueue.first {
            
            vertexQueue = Array(vertexQueue.dropFirst())
            
            if !visitedVertexes.contains(currentVertex) {
                visitedVertexes.append(currentVertex)
                let neighbours = graph.neighbours(ofVertex: currentVertex)
                vertexQueue.append(contentsOf: neighbours)
            }
            
        }
        
    }
}
