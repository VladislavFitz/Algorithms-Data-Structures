import Foundation

/// Search least common ancestor of two nodes in the binary tree
class LCAAlgorithm<Tree: BinaryTreeWithParent>: Algorithm {

  var input: Tree
  let u: Tree.Element
  let v: Tree.Element
  
  var output: Tree.Element?
    
  init(tree: Tree, u: Tree.Element, v: Tree.Element) {
    self.input = tree
    self.u = u
    self.v = v
  }
  
  /// - complexity: O(h), h is the height of the tree
  func perform() {
    guard
        var uNode = input.findNode(for: u),
        var depthU = input.depth(of: u),
        var vNode = input.findNode(for: v),
        var depthV = input.depth(of: v) else {
      return
    }
    
    while depthU != depthV {
      if depthU > depthV {
        depthU -= 1
        if let uParent = uNode.parent {
          uNode = uParent
        } else {
          return
        }
        
      } else {
        depthV -= 1
        if let vParent = vNode.parent {
          vNode = vParent
        } else {
          return
        }
      }
    }
    
    while uNode.element != vNode.element {
      if let uParent = uNode.parent {
        uNode = uParent
      } else {
        return
      }
      if let vParent = vNode.parent {
        vNode = vParent
      } else {
        return
      }
    }
    
    output = uNode.element
  }
  
}
