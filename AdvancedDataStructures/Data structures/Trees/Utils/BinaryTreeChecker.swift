//
//  BinaryTreeChecker.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 11/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct BinaryTreeChecker {
    
    static func isCorrect<T: BinaryTreeProtocol>(_ tree: T) -> Bool {
        
        if let leftBranch = tree.left, (leftBranch.element >= tree.element || !isCorrect(leftBranch)) {
            return false
        } 
        
        if let rightBranch = tree.right, (rightBranch.element < tree.element || !isCorrect(rightBranch))  {
            return false
        }
        
        return true
        
    }
    
}
