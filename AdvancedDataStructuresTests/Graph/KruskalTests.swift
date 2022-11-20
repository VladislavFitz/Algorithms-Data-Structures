//
//  KruskalTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav Fitc on 20.11.2022.
//  Copyright © 2022 Fitc. All rights reserved.
//

import Foundation
@testable import AdvancedDataStructures
import XCTest

class KruskalAlgorithmTests: XCTestCase {
  
  func testConnectedGraph() {
    
    /*
     
            4 -{6}- 3
           /       / \
         {9}    {11} {15}
         /      /      \
        5 -{2}- 2 -{10}-1
         \      |      /
          \     |     /
          {14} {9}  {7}
            \   |   /
             \  |  /
              \ | /
                0

    */
    
    var graph = AdjacencyMatrix(nodesCount: 6)
    graph.makeEdge(from: 0, to: 1, withWeight: 7)
    graph.makeEdge(from: 0, to: 2, withWeight: 9)
    graph.makeEdge(from: 0, to: 5, withWeight: 14)
    graph.makeEdge(from: 1, to: 2, withWeight: 10)
    graph.makeEdge(from: 1, to: 3, withWeight: 15)
    graph.makeEdge(from: 2, to: 3, withWeight: 11)
    graph.makeEdge(from: 2, to: 5, withWeight: 2)
    graph.makeEdge(from: 3, to: 4, withWeight: 6)
    graph.makeEdge(from: 4, to: 5, withWeight: 9)
    
    let kruskal = KruskalAlgorithm(graph: graph)
    
    kruskal.perform()
    
    let minSpanningForest = kruskal.minSpanningForest
    
    XCTAssertEqual(minSpanningForest.count, 1)

    guard let (vertices, spanningTree) = minSpanningForest.first else {
      XCTFail()
      return
    }
    XCTAssertEqual(vertices, [0, 1, 2, 3, 4, 5])
    XCTAssertEqual(spanningTree.count, 5)
    let expectedSpanningTree = [
      Edge(from: 2, to: 5, weight: 2),
      Edge(from: 0, to: 1, weight: 7),
      Edge(from: 0, to: 2, weight: 9),
      Edge(from: 3, to: 4, weight: 6),
      Edge(from: 4, to: 5, weight: 9),
    ]
    for edge in expectedSpanningTree {
      XCTAssertTrue(spanningTree.contains(edge))
    }
  }
  
  func testDisconnectedGraph() {
    /*
     
            4       3
           /       / \
         {9}    {11} {15}
         /      /      \
        5       2 -{10}-1
                |      /
                |     /
               {9}  {7}
                |   /
                |  /
                | /
                0

    */
    
    var graph = AdjacencyMatrix(nodesCount: 6)
    graph.makeEdge(from: 0, to: 1, withWeight: 7)
    graph.makeEdge(from: 0, to: 2, withWeight: 9)
    graph.makeEdge(from: 1, to: 2, withWeight: 10)
    graph.makeEdge(from: 1, to: 3, withWeight: 15)
    graph.makeEdge(from: 2, to: 3, withWeight: 11)
    graph.makeEdge(from: 4, to: 5, withWeight: 9)
    
    let kruskal = KruskalAlgorithm(graph: graph)
    
    kruskal.perform()
    
    let minSpanningForest = kruskal.minSpanningForest
    
    XCTAssertEqual(minSpanningForest.count, 2)
    
    let treeA: Set<Int> = [4, 5]
    let spanningTreeA = minSpanningForest[treeA]!
    
    let expectedSpanningTreeA = [
      Edge(from: 4, to: 5, weight: 9)
    ]
    XCTAssertEqual(spanningTreeA.count, 1)
    for edge in expectedSpanningTreeA {
      XCTAssertTrue(spanningTreeA.contains(edge))
    }
    
    let treeB: Set<Int> = [0, 1, 2, 3]
    let spanningTreeB = minSpanningForest[treeB]!
    let expectedSpanningTreeB = [
      Edge(from: 0, to: 1, weight: 7),
      Edge(from: 0, to: 2, weight: 9),
      Edge(from: 2, to: 3, weight: 11),
    ]
    XCTAssertEqual(spanningTreeB.count, 3)
    print(spanningTreeB)
    for edge in expectedSpanningTreeB {
      XCTAssertTrue(spanningTreeB.contains(edge))
    }

  }

  
}
