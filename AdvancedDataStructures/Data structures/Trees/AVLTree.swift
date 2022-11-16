import Foundation
/**
 A self-balancing binary search tree.
 In an AVL tree, the heights of the two child subtrees of any node differ by at most one; if at any time they differ by more than one, rebalancing is done to restore this property.
 Lookup, insertion, and deletion all take O(log n) time in both the average and worst cases, where n is the number of nodes in the tree prior to the operation.
 Insertions and deletions may require the tree to be rebalanced by one or more tree rotations.
 */
enum AVLTree<Element: Comparable & Equatable>: BinaryTreeProtocol {
    
  case empty
  indirect case node(element: Element, left: AVLTree, right: AVLTree)
  
  init(element: Element, left: AVLTree? = nil, right: AVLTree? = nil) {
    self = .node(element: element, left: left ?? .empty, right: right ?? .empty)
  }
  
  var element: Element {
    if case .node(element: let element, left: _, right: _) = self {
      return element
    } else {
      fatalError()
    }
  }
  
  var left: Self? {
    if case .node(element: _, left: let left, right: _) = self {
      if case .empty = left {
        return nil
      } else {
        return left
      }
    } else {
      return nil
    }
  }
  
  var right: Self? {
    if case .node(element: _, left: _, right: let right) = self {
      if case .empty = right {
        return nil
      } else {
        return right
      }
    } else {
      return nil
    }
  }
  
  var nodeDescription: String {
    return "\(element) [\(balanceFactor)]"
  }
  
  /// Whether the tree is balanced
  var isBalanced: Bool {
    return [-1, 0, 1].contains(balanceFactor)
  }
  
  /// Balance factor of AVL tree. Balance factor ∈ {–1,0,+1} for balanced AVL tree.
  fileprivate var balanceFactor: Int {
    return (right?.height ?? 0) - (left?.height ?? 0)
  }
  
  /// Returns balanced AVL tree
  fileprivate func balanced() -> AVLTree {
    
    switch self {
    case .empty:
      return self
      
    case .node(element: let element, left: let left, right: let right):
      
      switch balanceFactor {
        /*
         If balance factor == 2, that means that tree is misbalanced to right side.
         One should turn it left.
         */
      case 2:
        let intermediateTree: AVLTree
        
        /*
         If balance factor of right subtree is negative, that means that one need a big left turn
         So one need to turn right branch right previously
         */
        
        if right.balanceFactor < 0 {
          intermediateTree = AVLTree.node(element: element,
                                          left: left,
                                          right: right.rotated(by: .right))
        } else {
          intermediateTree = self
        }
        
        return intermediateTree.rotated(by: .left)
        /*
         If balance factor == -2, that means that tree is misbalanced to left side.
         One should turn it right.
         */
      case -2:
        let intermediateTree: AVLTree
        /*
         If balance factor of left subtree is positive, that means that one need a big right turn
         So one need to turn left branch left previously
         */
        if left.balanceFactor > 0 {
          intermediateTree = AVLTree.node(element: element,
                                          left: left.rotated(by: .left),
                                          right: right)
        } else {
          intermediateTree = self
        }
        
        return intermediateTree.rotated(by: .right)
        
      default:
        return self
      }
    }
    
  }
  
}

//MARK: - Operations
extension AVLTree {
  
  func insert(_ element: Element) -> Self {
    switch self {
    case .empty:
      return .node(element: element,
                   left: .empty,
                   right: .empty)
      
    case .node(element: let currentElement, left: let left, right: let right):
      if currentElement < element {
        return .node(element: currentElement,
                     left: left,
                     right: right.insert(element)).balanced()
      } else if currentElement > element {
        return .node(element: currentElement,
                     left: left.insert(element),
                     right: right).balanced()
      } else {
        return self
      }
    }
  }
  
  func remove(_ element: Element) -> Self? {
    
    // Returns tuple of min element of tree and tree without this min element
    func extractMin(tree: AVLTree) -> (min: Element?, tree: AVLTree) {
      switch tree {
      case .empty:
        return (min: .none, tree: self)
        
      case .node(element: let element, left: .empty, right: .node):
        return (min: element, tree: right!)
        
      case .node(element: let element, left: let left, right: let right):
        let (minElement, updatedLeft) = extractMin(tree: left)
        return (min: minElement, tree: AVLTree.node(element: element, left: updatedLeft, right: right).balanced())
      }
    }
    
    switch self {
    case .empty:
      return self

    // If the required element is lower than the element of current node, return tree with updated left branch
    case .node(element: let currentElement, left: let left, right: let right) where element < currentElement:
      let updatedLeft = left.remove(element) ?? .empty
      return AVLTree.node(element: currentElement,
                          left: updatedLeft,
                          right: right).balanced()
      
    // If thr required element is greater than the element of current node, return tree with updated right branch
    case .node(element: let currentElement, left: let left, right: let right) where element > currentElement:
      let updatedRight = right.remove(element) ?? .empty
      return AVLTree.node(element: currentElement,
                          left: left,
                          right: updatedRight).balanced()
    // If searching key is equal to key of current node:
      
    // If right branch is empty, just return left branch
    case .node(element: _, left: let left, right: .empty):
      return left
      
    // Otherwise, extract min node from right branch, and replace current node by it
    case .node(element: _, left: let left, right: let right):
      let (minElement, updatedRight) = extractMin(tree: right)
      guard let rightMin = minElement else { return left }
      return AVLTree.node(element: rightMin,
                          left: left,
                          right: updatedRight).balanced()
    }
    
  }
  
}
