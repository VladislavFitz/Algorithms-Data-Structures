//
//  BinaryHeap.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 20.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

/**
 Heap is a specialized tree-based data structure which is essentially an almost complete tree that satisfies the heap property:
 In a max heap, for any given node C, if P is a parent node of C, then the key (the value) of P is greater than or equal to the key of C.
 In a min heap, the key of P is less than or equal to the key of C.
 The node at the "top" of the heap (with no parents) is called the root node.
 */
struct BinaryHeap<Element: Comparable & Equatable>: StatefulBinaryTree {
    
  /// Defines the type of the heap: max or min
  let type: HeapType
  
  /// The array storing the heap's elements
  var elements: [Element] = []
    
  /**
   - elements: initial heap element(s)
   - direction: defines the type of the heap: max or min
   */
  init(_ elements: Element..., type: HeapType = .max) {
    self.init(elements, type: type)
  }
  
  init(element: Element, left: BinaryHeap<Element>?, right: BinaryHeap<Element>?) {
    self.init(element)
  }
  
  /**
   - elements: sequence containing the initial heap elements
   - direction: defines the type of the heap: max or min
   */
  init<S: Sequence>(_ sequence: S, type: HeapType = .max) where S.Element == Element {
    
    self.type = type
    
    for element in sequence {
      insert(element)
    }
    
    for element in (0...(elements.count/2)).reversed() {
      heapify(fromElementAtIndex: element)
    }
  }
  
  /// Whether the heap is empty
  var isEmpty: Bool {
    return elements.isEmpty
  }
  
  /// Returns the binary heap with the root element at given index
  /// If the index is out of `elements` array bounds, returns `nil`
  func subHeapFromIndex(_ index: Int) -> BinaryHeap? {
    
    guard index >= 0 || index < elements.count else { return nil }
    
    var subHeapIndexes: Set<Int> = []
    
    var indexesToAddQueue: [Int] = [index]
    
    while let indexToAdd = indexesToAddQueue.first {
      
      subHeapIndexes.insert(indexToAdd)
      
      let li = leftIndex(forElementAtIndex: indexToAdd)
      if li < elements.count {
        indexesToAddQueue.append(li)
      }
      
      let ri = rightIndex(forElementAtIndex: indexToAdd)
      if ri < elements.count {
        indexesToAddQueue.append(ri)
      }
      
      indexesToAddQueue = Array(indexesToAddQueue.dropFirst())
      
    }
    
    let subHeapElements = elements.enumerated().filter({ subHeapIndexes.contains($0.offset) }).map({ $0.element })
    
    return BinaryHeap(subHeapElements)
  }
  
  // The binary heap representing the left subtree
  // of the current root element
  var left: BinaryHeap? {
    return subHeapFromIndex(leftIndex(forElementAtIndex: 0))
  }
  
  // The binary heap representing the right subtree
  // of the current root element
  var right: BinaryHeap? {
    return subHeapFromIndex(rightIndex(forElementAtIndex: 0))
  }
  
  /// The root element of the heap.
  /// Depending on the heap type, it's the max or the min element in the heap
  var root: Element? {
    return elements.first
  }
  
  var element: Element {
    return root!
  }
  
  /// Insert element into the heap
  /// - complexity: average: O(1), worst: O(log n)
  /// - parameter element: the element to insert
  mutating func insert(_ element: Element) {
    
    elements.append(element)
    
    var elementIndex = elements.endIndex - 1
    var parentIndex = (elementIndex - 1) / 2
    
    while elementIndex > 0 && !ordered(elements[elementIndex], elements[parentIndex]) {
      elements.swapAt(elementIndex, parentIndex)
      elementIndex = parentIndex
      parentIndex = (elementIndex - 1) / 2
    }
  }
  
  /// Remove element from the heap if present
  /// - complexity: O(n)
  /// - parameter element: element to remove
  mutating func remove(_ elementToRemove: Element) {
    for (index, element) in elements.enumerated() {
      if element == elementToRemove {
        _ = remove(atIndex: index)
      }
    }
  }
  
  /// Extract the root element from the heap
  /// - complexity: O(log n)
  /// - returns: the root element
  mutating func pop() -> Element? {
    return remove(atIndex: 0)
  }
  
  private mutating func remove(atIndex index: Int) -> Element? {
    
    guard let rootElement = elements.first else { return .none }
    
    elements[index] = elements[elements.endIndex-1]
    elements.remove(at: elements.endIndex-1)
    
    heapify(fromElementAtIndex: index)
    
    return rootElement
    
  }
  
  /// Restore the heap property starting from the element at the provided index
  /// elementIndex: index of the element to perform the heapify action from
  private mutating func heapify(fromElementAtIndex elementIndex: Int) {
    
    guard !elements.isEmpty else { return }
    
    var elementIndex = elementIndex
    var largestChildIndex = elementIndex
    
    while true {
      
      if let leftChild = leftChildForElement(atIndex: elementIndex), !ordered(leftChild, elements[largestChildIndex]) {
        largestChildIndex = leftIndex(forElementAtIndex: elementIndex)
      }
      
      if let rightChild = rightChildForElement(atIndex: elementIndex), !ordered(rightChild, elements[largestChildIndex]) {
        largestChildIndex = rightIndex(forElementAtIndex: elementIndex)
      }
      
      if largestChildIndex == elementIndex {
        break
      }
      
      elements.swapAt(elementIndex, largestChildIndex)
      elementIndex = largestChildIndex
      
    }
    
  }
  
  /// Whether the order of elements in the heap conforms to the heap property
  func isCorrect() -> Bool {
    
    for elementIndex in 0..<elements.endIndex {
      
      let currentElement = elements[elementIndex]
      
      if let leftChild = leftChildForElement(atIndex: elementIndex), !ordered(leftChild, currentElement) {
        return false
      }
      
      if let rightChild = rightChildForElement(atIndex: elementIndex), !ordered(rightChild, currentElement) {
        return false
      }
      
    }
    
    return true
    
  }
  
  /// Defines the elements ordering depending on the heap type
  private func ordered(_ lhs: Element, _ rhs: Element) -> Bool {
    switch type {
    case .max:
      return lhs < rhs
    case .min:
      return lhs > rhs
    }
  }
  
  /// Number of elements in the heap
  var count: Int {
    return elements.count
  }
  
  /// Calculate the  index of the root node of the left subtree of the node at given index in the elements array
  /// - parameter index: the given index
  /// - returns:the index of the left subtree element
  fileprivate func leftIndex(forElementAtIndex index: Int) -> Int {
    return 2 * index + 1
  }
  
  /// Calculate the index of the root node of the right subtree of the node at given index in the elements array
  /// - parameter index: the given index
  /// - returns: the index of the right subtree element
  fileprivate func rightIndex(forElementAtIndex index: Int) -> Int {
    return 2 * index + 2
  }
  
  /// The left child of the element at given index
  /// - parameter index: the given index
  /// - returns: the left child element if present, nil otherwise
  func leftChildForElement(atIndex index: Int) -> Element? {
    
    let leftElementIndex = leftIndex(forElementAtIndex: index)
    
    if leftElementIndex < count {
      return elements[leftElementIndex]
    } else {
      return .none
    }
    
  }
  
  /// The right child of the element at given index
  /// - parameter index: the given index
  /// - returns: the right child element if present, nil otherwise
  func rightChildForElement(atIndex index: Int) -> Element? {
    
    let rightElementIndex = rightIndex(forElementAtIndex: index)
    
    if rightElementIndex < count {
      return elements[rightElementIndex]
    } else {
      return .none
    }
    
  }
  
  var nodeDescription: String {
    return elements.first.flatMap({ "\($0)" }) ?? "nil"
  }
  
  var internalDescription: String {
    return "\(elements)"
  }
  
}
  
enum HeapType {
  /// Heap with the min element
  case min
  /// Heap with the max element a
  case max
}
  
extension BinaryHeap: CustomStringConvertible {
  
  var description: String {
    return BinaryTreePrinter.treeString(self, using: { (heap) in
      return ("\(heap.nodeDescription)", heap.left, heap.right)
    })
  }
  
}
