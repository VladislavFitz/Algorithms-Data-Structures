//
//  TreeTraversal.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 05/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

protocol TreeTraversal {
    associatedtype Key: Comparable
    associatedtype Value
    
    var visit: (BinaryTree<Key, Value>) -> () { get }
    func traverse(_ tree: BinaryTree<Key, Value>)
}
