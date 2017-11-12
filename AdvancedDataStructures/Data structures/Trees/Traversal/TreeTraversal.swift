//
//  TreeTraversal.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 05/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

protocol TreeTraversal {

    associatedtype Tree: BinaryTreeProtocol
    
    var visit: (Tree) -> () { get }
    func traverse(_ tree: Tree)
}
