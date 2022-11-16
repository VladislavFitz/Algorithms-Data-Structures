//
//  StatefulBinaryTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 16.11.2022.
//  Copyright © 2022 Fitc. All rights reserved.
//

import Foundation

protocol StatefulBinaryTree: BinaryTree {
  
  /// Insert element into the tree
  mutating func insert(_ element: Element)
  
  /// Remove element from the tree
  mutating func remove(_ element: Element)
  
}

extension StatefulBinaryTree {
  
  init(_ elements: Element...) {
    self.init(elements)!
  }
  
  init?<S: Sequence>(_ sequence: S) where S.Element == Element {
    guard let first = sequence.map({ $0 }).first else { return nil }
    self.init(element: first, left: .none, right: .none)
    sequence
      .dropFirst()
      .forEach { element in
        insert(element)
      }
  }
  
  static func with<S: Sequence>(_ sequence: S) -> Self? where S.Element == Element {
    Self(sequence)
  }
  
}
