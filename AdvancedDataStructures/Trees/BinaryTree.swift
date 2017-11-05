//
//  BinaryTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 24.10.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

enum NodePosition {
    case root
    case leftSubtree
    case rightSubtree
}

class BinaryTree<Key: Comparable, Payload> {
    
    var key: Key
    var payload: Payload
    var left: BinaryTree? {
        didSet {
            left?.parent = self
        }
    }
    
    var right: BinaryTree? {
        didSet {
            right?.parent = self
        }
    }
    
    weak var parent: BinaryTree?
    
    var nodePosition: NodePosition {
        
        if parent == nil {
            return .root
        }
        
        if parent?.left?.key == key {
            return .leftSubtree
        }
        
        if parent?.right?.key == key {
            return .rightSubtree
        }
        
        fatalError("Impossible position")
    }
    
    init(key: Key, payload: Payload, left: BinaryTree? = .none, right: BinaryTree? = .none, parent: BinaryTree? = .none) {
        self.key = key
        self.payload = payload
        self.left = left
        self.right = right
        self.parent = parent
    }
    
    convenience init?(array: [(key: Key, value: Payload)]) {
        guard let firstElement = array.first else { return nil }
        self.init(key: firstElement.key, payload: firstElement.value)
        array.dropFirst().forEach { set($0.value, for: $0.key) }
    }
    
    static func with<K: Comparable>(array: [K]) -> BinaryTree<K, Void>? {
        let treeArray = array.map({ (key: $0, value: ()) })
        return BinaryTree<K, Void>(array: treeArray)
    }
    
    func value(for key: Key) -> Payload? {
        
        if key == self.key {
            return payload
        } else if key < self.key {
            return left?.value(for: key)
        } else {
            return right?.value(for: key)
        }
        
    }
    
    func set(_ value: Payload, for key: Key) {
        
        if key == self.key {
            
            self.payload = value
            
        } else if key < self.key {
            
            if let leftBranch = self.left {
                leftBranch.set(value, for: key)
            } else {
                self.left = BinaryTree(key: key, payload: value, parent: self)
            }
            
        } else {
            
            if let rightBranch = self.right {
                rightBranch.set(value, for: key)
            } else {
                self.right = BinaryTree(key: key, payload: value, parent: self)
            }
            
        }
        
    }
    
    func min() -> BinaryTree {
        
        if let leftSubree = self.left {
            return leftSubree.min()
        } else {
            return self
        }
        
    }
    
    func max() -> BinaryTree {
        
        if let rightSubtree = self.right {
            return rightSubtree.max()
        } else {
            return self
        }
        
    }
    
    func next() -> BinaryTree? {
        
        if let rightSubtree = self.right {
            return rightSubtree.min()
        }
        
        var node = self
        
        while let parent = node.parent, node.nodePosition == .rightSubtree {
            node = parent
        }
        
        return node.parent
        
    }
    
    func previous() -> BinaryTree? {
        
        if let leftSubtree = self.left {
            return leftSubtree.max()
        }
        
        var node = self
        
        while let parent = node.parent, node.nodePosition == .leftSubtree {
            node = parent
        }
        
        return node.parent
        
    }
    
    func root() -> BinaryTree {
        var current: BinaryTree = self
        
        while let parent = current.parent {
            current = parent
        }
        
        return current
    }
    
    func height() -> Int {
        let leftHeight = left?.height() ?? 0
        let rightHeight = right?.height() ?? 0
        return Swift.max(leftHeight, rightHeight) + 1
    }
    
    func removeValue(for key: Key) -> BinaryTree? {
        
        if key == self.key {
            
            switch (left, right) {
            case (.none, .none):
                
                switch nodePosition {
                case .leftSubtree:
                    parent?.left = .none
                    return parent?.root()
                    
                case .rightSubtree:
                    parent?.right = .none
                    return parent?.root()
                    
                case .root:
                    return parent?.root()
                }
                
            case (let leftSubtree, .none):
                
                switch nodePosition {
                case .leftSubtree:
                    parent?.left = leftSubtree
                    return parent?.root()
                    
                case .rightSubtree:
                    parent?.right = leftSubtree
                    return parent?.root()
                    
                case .root:
                    return parent?.root()
                }
                
            case (.none, let rightSubtree):
                
                switch nodePosition {
                case .leftSubtree:
                    parent?.left = rightSubtree
                    return parent?.root()
                    
                case .rightSubtree:
                    parent?.right = rightSubtree
                    return parent?.root()
                    
                case .root:
                    return parent?.root()
                }
                
            case (let leftSubtree, let rightSubtree):
                let nextElement = self.next()!
                _ = removeValue(for: nextElement.key)
                nextElement.left = leftSubtree
                nextElement.right = rightSubtree
                nextElement.parent = parent
                return nextElement.root()
            }
            
        } else if key < self.key {
            return left?.removeValue(for: key) ?? self.root()
        } else {
            return right?.removeValue(for: key) ?? self.root()
        }
        
    }
    
    func rotated(by direction: RotationDirection) -> BinaryTree {
        
        switch direction {
        case .left:
            
            let leftBranch = BinaryTree(key: key, payload: payload, left: left, right: right?.left, parent: right)
            
            return BinaryTree(key: right!.key, payload: right!.payload, left: leftBranch, right: right!.right, parent: .none)
            
        case .right:
            
            let rightBranch = BinaryTree(key: key, payload: payload, left: left?.right, right: right, parent: left)
            
            return BinaryTree(key: left!.key, payload: left!.payload, left: left?.left, right: rightBranch, parent: .none)
            
        }
        
    }
    
    
    func findNode(for key: Key) -> BinaryTree? {
        
        if key == self.key {
            return self
        } else if key > self.key {
            return self.right?.findNode(for: key)
        } else {
            return self.left?.findNode(for: key)
        }
        
    }
    
}

extension BinaryTree: CustomStringConvertible {
    
    var description: String {
        
        return BinaryTreePrinter.treeString(self, using: { (tree) in
            return ("\(tree.key)", tree.left, tree.right)
        })
        
    }
    
    func draw() {
        left?.draw(indent: "", "    ", " |  ")
        print("\(key)")
        right?.draw(indent: "", " |  ", "    ")
    }
    
    func draw(indent: String, _ leftIndent: String, _ rightIndent: String) {
        left?.draw(indent: leftIndent, leftIndent + "    ", leftIndent + " |  ")
        print(indent + " +- " + "\(key)")
        right?.draw(indent: rightIndent, rightIndent + " |  ", rightIndent + "    ")
    }
    
}
