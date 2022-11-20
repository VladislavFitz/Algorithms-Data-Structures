import Foundation

///  A data structure that stores a collection of disjoint (non-overlapping) sets.
///  Equivalently, it stores a partition of a set into disjoint subsets.
///  It provides operations for adding new sets, merging sets (replacing them by their union), and finding a representative member of a set.
///  The last operation makes it possible to find out efficiently if any two elements are in the same or different sets.
struct UnionFind {
    
  /// Defines the parental relationship between the elements
  /// parents[i] = j means that j is the parent element of i
  /// parents[x] = x means that the x element is a singleton
  private var parents: [Int]
  
  /// - parameter capacity: the max count of elements
  init(capacity: Int = 1000) {
    parents = .init(repeating: -1, count: capacity)
  }
  
  /// Make a  set with a given element
  /// If the element is already a part of the set, it detaches the element from its parent
  /// - parameter element: the givent element
  /// - complexity: O(1)
  mutating func makeSet(_ element: Int) {
    parents[element] = element
  }
  
  /// Find a root (representative) of the set to which the element belongs
  /// - parameter element: the given element
  /// - complexity: O(1) (amortized)
  mutating func find(_ element: Int) -> Int {
    let parent = parents[element]
    
    if parent == element {
      return parent
    }
    
    let grandParent = find(parent)
    // path compression while looking for the parent
    parents[element] = grandParent
    return grandParent
  }
  
  /// Unite two elements
  /// - parameter lElement: first element to unite
  /// - parameter rElement: second element to unite
  /// - complexity: O(1) amortized
  mutating func unite(_ lElement: Int, _ rElement: Int) {
    let lElementParent = find(lElement)
    let rElementParent = find(rElement)
    
    if lElementParent == rElementParent {
      return
    }
    
    if arc4random() % 2 == 0 {
      parents[lElementParent] = rElementParent
    } else {
      parents[rElementParent] = lElementParent
    }
  }
  
  /// Return bool value indicating if the elements belong to the same set
  /// - complexity: O(n)
  public mutating func areJoint(_ elements: Int...) -> Bool {
    return areJoint(elements)
  }
  
  /// Return bool value indicating if the elements belong to the same set
  /// - complexity: O(n)
  public mutating func areJoint<S: Sequence>(_ elements: S) -> Bool where S.Element == Int {
    let elements = Array(elements)
    guard let firstElement = elements.first else {
      return false
    }
    let firstElementParent = find(firstElement)
    return elements
      .dropFirst()
      .allSatisfy { element in find(element) == firstElementParent }
  }
  
  /// Whether the set contains the element
  /// - parameter element: the given element
  /// - complexity: O(1)
  public func contains(_ element: Int) -> Bool {
    return parents[element] != -1
  }
  
  /// Returns all the disjoint sets
  /// - complexity: O(n)
  public mutating func allSets() -> [Set<Int>] {
    var output = [Int: Set<Int>]()
    for element in parents where element != -1 {
      let root = find(element)
      output[root] = (output[root] ?? []).union([element])
    }
    return Array(output.values)
  }
  
  /// Number of elements in all sets
  var count: Int {
    return parents.filter { $0 >= 0 }.count
  }
  
  /// Number of sets
  var setCount: Int {
    return Set(parents.filter { $0 >= 0 }).count
  }
  
}
