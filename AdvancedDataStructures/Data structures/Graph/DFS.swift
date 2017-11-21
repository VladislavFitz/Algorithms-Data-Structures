//
//  DFS.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 21.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct DepthFirstSearch: Algorithm {
    
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
    
    init(graph: AdjacencyMatrix, startVertex: Int) {
        self.graph = graph
        self.startVertex = startVertex
    }
    
    mutating func perform() {
        
        func dfs(vertex: Int) {
            
            visitedVertexes.append(vertex)
            
            for neighbour in graph.neighbours(ofVertex: vertex) where !visitedVertexes.contains(neighbour) {
                dfs(vertex: neighbour)
            }
            
        }
        
        dfs(vertex: startVertex)
        
    }
    
}
