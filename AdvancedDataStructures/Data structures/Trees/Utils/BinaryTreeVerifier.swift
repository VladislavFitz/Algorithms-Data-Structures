//
//  BinaryTreeVerifier.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 11/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct BinaryTreeVerifier {
    
    static func isCorrect<T: BinaryTreeProtocol>(_ tree: T) -> Bool {
        
        if let leftBranch = tree.left, (leftBranch.key >= tree.key || !isCorrect(leftBranch)) {
            return false
        } 
        
        if let rightBranch = tree.right, (rightBranch.key < tree.key || !isCorrect(rightBranch))  {
            return false
        }
        
        return true
        
    }
    
}
