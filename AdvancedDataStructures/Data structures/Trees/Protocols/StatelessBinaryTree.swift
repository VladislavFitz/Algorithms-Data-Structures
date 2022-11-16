//
//  StatelessBinaryTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 16.11.2022.
//  Copyright © 2022 Fitc. All rights reserved.
//

import Foundation

protocol StatelessBinaryTree: BinaryTreeProtocol {
 
  /// Insert element into the tree
  /// - returns: the update tree
  func inserting(_ element: Element) -> Self
  
  /// Remove element from the tree
  /// - returns: the updated tree
  func removing(_ element: Element) -> Self?
  
}
