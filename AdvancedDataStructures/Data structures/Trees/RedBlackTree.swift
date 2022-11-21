//
//  RedBlackTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 01.03.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

enum Color {
  case red, black
}

/**
 - Root and leaves are black
 - Red node has black parent
 - All paths from each node contain the same quantity of black nodes
 – Black node may have black parent
 */

final class RedBlackTree<Element: Comparable & Equatable>: BinaryTreeWithParent {
  
  var element: Element
  var left: RedBlackTree?
  var right: RedBlackTree?
  
  weak var parent: RedBlackTree?
  
  var color: Color
  
  init(element: Element, left: RedBlackTree?, right: RedBlackTree?) {
    self.element = element
    self.left = left
    self.right = right
    self.parent = nil
    self.color = .black
  }
  
  init(element: Element, left: RedBlackTree?, right: RedBlackTree?, parent: RedBlackTree?) {
    self.element = element
    self.left = left
    self.right = right
    self.color = .black
    self.parent = parent
  }
  
  init(element: Element, left: RedBlackTree?, right: RedBlackTree?, color: Color, parent: RedBlackTree? = .none) {
    self.element = element
    self.left = left
    self.right = right
    self.color = color
    self.parent = parent
  }
  
  var nodeDescription: String {
    return "\(element) [\(color)]"
  }
  
  func with(parent: RedBlackTree?) -> RedBlackTree {
    self.parent = parent
    return self
  }
  
  func with(color: Color) -> RedBlackTree {
    self.color = color
    return self
  }
  
  func with(left: RedBlackTree?) -> RedBlackTree {
    self.left = left
    return self
  }
  
  func with(right: RedBlackTree?) -> RedBlackTree {
    self.right = right
    return self
  }
  
  func with(element: Element) -> RedBlackTree {
    self.element = element
    return self
  }
  
}

extension RedBlackTree {
  
  func insert(_ element: Element) {
    
    let currentElement = self.element
        
    var shouldCheckBalance: Bool = false
    var uncleColor: Color = .black
    
    if element > currentElement  {
            
      if let right = self.right {
        right.insert(element)
      } else {
        shouldCheckBalance = color == .red
        uncleColor = left?.color ?? .black
        right = RedBlackTree(element: element, left: .none, right: .none, color: .red, parent: self)
      }
            
    } else if element < currentElement {
            
      if let left = self.left {
        left.insert(element)
      } else {
        shouldCheckBalance = color == .red
        uncleColor = right?.color ?? .black
        left = RedBlackTree(element: element, left: .none, right: .none, color: .red, parent: self)
      }
            
    } else {
      self.element = element
    }
    
    guard shouldCheckBalance else  { return }
    
    switch uncleColor {
    case .red:
      self.color = .black
      self.brother?.color = .black
      self.parent?.color = .red
      
    case .black:
      break
    }
    
  }
  
  func remove(_ element: Element) {
    //TODO:
  }
  
}
