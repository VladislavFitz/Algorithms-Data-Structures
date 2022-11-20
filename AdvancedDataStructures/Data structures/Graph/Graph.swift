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
  
  func hasEdge(from nodeA: Int, to nodeB: Int) -> Bool
  mutating func makeEdge(from nodeA: Int, to nodeB: Int)
  mutating func removeEdge(from nodeA: Int, to nodeB: Int)
  
}

protocol WeightedGraph: DirectedGraph {
  
  func edgeWeight(from nodeA: Int, to nodeB: Int) -> Int
  mutating func makeEdge(from nodeA: Int, to nodeB: Int, withWeight weight: Int)
  
}

struct Edge: Hashable {
  let from: Int
  let to: Int
  let weight: Int
  
  init(from: Int, to: Int, weight: Int = 1) {
    self.from = from
    self.to = to
    self.weight = weight
  }
}

extension Edge: CustomStringConvertible {
  
  var description: String {
    "(\(from) -> \(to)) { \(weight) }"
  }
  
}


struct AdjacencyMatrix: WeightedGraph {
  
  private var matrix: Array<Array<Int>>
  
  subscript(_ src: Int, _ dest:Int) -> Int {
    get {
      return matrix[src][dest]
    }
    set {
      matrix[src][dest] = newValue
    }
  }
  
  var nodesCount: Int {
    return matrix.count
  }
  
  func neighbours(ofVertex vertex: Int) -> [Int] {
    return matrix[vertex].enumerated().filter({ $0.element != 0 }).map({ $0.offset })
  }
  
  init(nodesCount: Int) {
    self.matrix = Array<Array<Int>>(repeating: Array<Int>(repeating: 0, count: nodesCount), count: nodesCount)
  }
  
  func hasEdge(from nodeA: Int, to nodeB: Int) -> Bool {
    return matrix[nodeA][nodeB] > 0
  }
  
  mutating func removeEdge(from nodeA: Int, to nodeB: Int) {
    matrix[nodeA][nodeB] = 0
    matrix[nodeB][nodeA] = 0
  }
  
  func edgeWeight(from nodeA: Int, to nodeB: Int) -> Int {
    return matrix[nodeA][nodeB]
  }
  
  mutating func makeEdge(from nodeA: Int, to nodeB: Int) {
    makeEdge(from: nodeA, to: nodeB, withWeight: 1)
  }
  
  mutating func makeEdge(from nodeA: Int, to nodeB: Int, withWeight weight: Int) {
    matrix[nodeA][nodeB] = weight
    matrix[nodeB][nodeA] = weight
  }
  
  func getEdges() -> [Edge] {
    var output: [Edge] = []
    for (src, row) in matrix.enumerated() {
      for (dst, weight) in row.enumerated() where weight > 0 {
        output.append(Edge(from: src, to: dst, weight: weight))
      }
    }
    return output
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
  
  mutating func makeEdge(from nodeA: Int, to nodeB: Int) {
    list[nodeA].insert(nodeB)
    list[nodeB].insert(nodeA)
  }
  
  mutating func removeEdge(from nodeA: Int, to nodeB: Int) {
    list[nodeA].remove(nodeB)
    list[nodeB].remove(nodeA)
  }
  
}
