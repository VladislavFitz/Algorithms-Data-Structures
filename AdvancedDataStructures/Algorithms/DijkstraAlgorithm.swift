//
//  DijkstraAlgorithm.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 19/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

/// Dijkstra's algorithm allows us to find the shortest path between any two vertices of a graph.
class DijkstraAlgorithm: Algorithm {
  
  typealias Input = AdjacencyMatrix
  typealias Output = [Int: Int]
  
  var input: AdjacencyMatrix {
    return graph
  }
  
  var output: [Int : Int] {
    return paths
  }
  
  /// The matrix graph representation
  /// The graph might be connected
  /// The edge weight might be positive
  let graph: AdjacencyMatrix
  
  /// The identifier of the vertex, the shortest paths from which are searched to all other vertices
  let sourceVertex: Int
  
  /// The set containing the non-visited vertices during the algorithm execution
  /// In the beginning contains all the graph vertices
  private var unvisitedVertices: Set<Int>
  
  /// The dictionary containing the length of the shortest paths
  /// The key is the identifier of the destination vertex
  /// The value is the path length
  private var paths: [Int: Int]
  
  
  /// - parameter graph: the matrix graph representation
  /// The matrix graph representation
  /// The graph might be connected
  /// The edge weight might be positive
  /// - parameter sourceVertex: the identifier of the vertex, the shortest paths from which are searched to all other vertices
  init(graph: AdjacencyMatrix, sourceVertex: Int) {
    assert(sourceVertex < graph.nodesCount)
    self.graph = graph
    self.sourceVertex = sourceVertex
    self.unvisitedVertices = Set(0..<graph.nodesCount)
    self.paths = [:]
    
    for element in 0..<graph.nodesCount {
      paths[element] = .max
    }
    paths[sourceVertex] = 0
    
  }
  
  func perform() {
    
    var currentVertex = sourceVertex
    
    while !unvisitedVertices.isEmpty {
      
      var nearestNeighbour = (vertex: -1, weight: Int.max)
            
      for (neighbourVertex, weight) in graph[currentVertex].enumerated() where weight > 0 && unvisitedVertices.contains(neighbourVertex) {
        
        if paths[currentVertex]! + weight < paths[neighbourVertex]! {
          paths[neighbourVertex] = paths[currentVertex]! + weight
        }
        
        if weight < nearestNeighbour.weight  {
          nearestNeighbour = (vertex: neighbourVertex, weight: weight)
        }
        
      }
      
      unvisitedVertices.remove(currentVertex)
      currentVertex = nearestNeighbour.vertex
      
    }
    
  }
  
}
