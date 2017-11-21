//
//  DijkstraTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav Fitc on 19/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
@testable import AdvancedDataStructures
import XCTest

class DijkstraAlgorithmTests: XCTestCase {
    
    func testDijkstra() {
        
        
        
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
        graph.setArc(from: 0, to: 1, withWeight: 7)
        graph.setArc(from: 0, to: 2, withWeight: 9)
        graph.setArc(from: 0, to: 5, withWeight: 14)
        graph.setArc(from: 1, to: 2, withWeight: 10)
        graph.setArc(from: 1, to: 3, withWeight: 15)
        graph.setArc(from: 2, to: 3, withWeight: 11)
        graph.setArc(from: 2, to: 5, withWeight: 2)
        graph.setArc(from: 3, to: 4, withWeight: 6)
        graph.setArc(from: 4, to: 5, withWeight: 9)
        
        let dijkstra = DijkstraAlgorithm(graph: graph, fromVertex: 0)
        
        dijkstra.perform()
        
        XCTAssertEqual(dijkstra.output[0], 0)
        XCTAssertEqual(dijkstra.output[1], 7)
        XCTAssertEqual(dijkstra.output[2], 9)
        XCTAssertEqual(dijkstra.output[3], 20)
        XCTAssertEqual(dijkstra.output[4], 20)
        XCTAssertEqual(dijkstra.output[5], 11)
    }
    
}
