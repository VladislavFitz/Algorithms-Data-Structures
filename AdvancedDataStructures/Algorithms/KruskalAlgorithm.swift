import Foundation

/**
 Kruskal's algorithm finds a minimum spanning forest of an undirected edge-weighted graph.
 If the graph is connected, it finds a minimum spanning tree.
 A minimum spanning tree of a connected graph is a subset of the edges that forms a tree that i
 ncludes every vertex, where the sum of the weights of all the edges in the tree is minimized.
 For a disconnected graph, a minimum spanning forest is composed of a minimum
 spanning tree for each connected component.) It is a greedy algorithm in graph theory as in each
 step it adds the next lowest-weight edge that will not form a cycle to the minimum spanning forest
 */
class KruskalAlgorithm: Algorithm {
    

  var input: AdjacencyMatrix {
    return graph
  }
  
  var output: [[Edge]] {
    return Array(minSpanningForest.values)
  }
  
  /// The matrix graph representation
  /// The graph might be connected
  /// The edge weight might be positive
  let graph: AdjacencyMatrix

  /// The dictionary representing spanning forest of the graph
  /// - key: set of vertices covered by the tree
  /// - value: list of edges composing a spanning tree
  var minSpanningForest: [Set<Int>: [Edge]]
    
  init(graph: AdjacencyMatrix) {
    self.graph = graph
    self.minSpanningForest = [:]
  }
  
  /// - complexity: O(E log V)
  func perform() {
    var dsu = UnionFind(capacity: graph.nodesCount)
    for node in 0..<graph.nodesCount {
      dsu.makeSet(node)
    }
    let sortedEdges = graph.getEdges().sorted { l, r in l.weight < r.weight }

    for edge in sortedEdges where !dsu.areJoint(edge.from, edge.to) {
      /// Unite the vertices of the edge
      dsu.unite(edge.from, edge.to)
      
      let updatedKey: Set<Int>
      let updatedEdges: [Edge]
      
      let existingKeys = minSpanningForest.keys.filter { !$0.intersection([edge.from, edge.to]).isEmpty }
      if existingKeys.isEmpty {
        /// Insert new edge to the spanning forest
        updatedKey = [edge.from, edge.to]
        updatedEdges = [edge]
      } else {
        /// Find the key in the forest dictionary containing at least one of the edges vertices
        updatedKey = (existingKeys).reduce(Set<Int>()) { $0.union($1) }.union([edge.from, edge.to])
        /// Remove old key-value from the forest dictionary
        var edges = existingKeys.compactMap({ minSpanningForest.removeValue(forKey: $0) }).flatMap { $0 }
        /// Append the edge to the edges list
        edges.append(edge)
        updatedEdges = edges
      }
      minSpanningForest[updatedKey] = updatedEdges
    }
  }
  
}
