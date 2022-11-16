//
//  RandomizedTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 12/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

final class RandomizedTree<Element: Comparable & Equatable>: StatefulBinaryTree {
  
  var element: Element
  var left: RandomizedTree?
  var right: RandomizedTree?
  
  var size: Int
  
  init(element: Element, left: RandomizedTree?, right: RandomizedTree?) {
    self.element = element
    self.left = left
    self.right = right
    self.size = 1
  }
  
  func insert(_ element: Element) {
    _ = Self.insert(element, into: self)
  }
  
  func remove(_ element: Element) {
    _ = Self.remove(element, from: self)
  }
  
  var nodeDescription: String {
    return "\(element) [\(size)]"
  }
  
  static func insert(_ element: Element, into tree: RandomizedTree?) -> RandomizedTree {
    
    guard let tree = tree else { return RandomizedTree(element: element, left: .none, right: .none)  }
    
    if Int(arc4random()) % tree.size + 1 == 0 {
      return insertRoot(element, into: tree)
    }
    
    if tree.element > element {
      tree.left = insert(element, into: tree.left)
    } else {
      tree.right = insert(element, into: tree.right)
    }
    
    fixSize(of: tree)
    
    return tree
    
  }
  
  static func remove(_ element: Element, from tree: RandomizedTree?) -> RandomizedTree? {
    
    guard let tree = tree else { return .none }
    
    if element == tree.element {
      
      return join(tree.left, tree.right)
      
    } else if element < tree.element {
      
      tree.left = remove(element, from: tree.left)
      
    } else {
      
      tree.right = remove(element, from: tree.right)
      
    }
    
    return tree
    
  }
  
  //MARK: - Private functions
  
  private static func fixSize(of tree: RandomizedTree) {
    tree.size = tree.count
  }
  
  
  private static func insertRoot(_ element: Element, into tree: RandomizedTree?) -> RandomizedTree {
    
    guard let tree = tree else { return RandomizedTree.init(element: element, left: .none, right: .none)  }
    
    if tree.element == element {
      tree.element = element
      return tree
    } else if tree.element < element {
      return  insertRoot(element, into: tree.left).rotated(by: .right)
    } else {
      return insertRoot(element, into: tree.right).rotated(by: .left)
    }
    
  }
  
  private static func join(_ leftTree: RandomizedTree?, _ rightTree: RandomizedTree?) -> RandomizedTree? {
    
    guard let leftTree = leftTree else { return rightTree }
    guard let rightTree = rightTree else { return leftTree }
    
    if Int(arc4random()) % (leftTree.count + rightTree.count) < leftTree.count {
      
      leftTree.right = RandomizedTree.join(leftTree.right, rightTree)
      fixSize(of: leftTree)
      return leftTree
      
    } else {
      
      rightTree.left = RandomizedTree.join(leftTree, rightTree.left)
      fixSize(of: rightTree)
      return rightTree
      
    }
    
  }
  
}
