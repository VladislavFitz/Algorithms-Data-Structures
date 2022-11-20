//
//  DFSTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav Fitc on 21.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
@testable import AdvancedDataStructures
import XCTest

class DFSTests: XCTestCase {
  
  func testDFS() {
    
    /*
       4 - {6} --- 3
     /          /    \
   {9}       {11}   {15}
   /          /        \
   5 - {2} - 2 - {10} - 1
   \         |         /
    \        |        /
    {14}    {9}     {7}
      \      |      /
       \     |     /
        \    |    /
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
    
    var dfs = DepthFirstSearch(graph: graph, startVertex: 0)
    
    dfs.perform()
    
    XCTAssertEqual(dfs.visitedVertexes, [0, 1, 2, 3, 4, 5])
    
  }
  
}
