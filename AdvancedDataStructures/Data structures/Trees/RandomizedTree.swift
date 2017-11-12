//
//  RandomizedTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 12/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

final class RandomizedTree<Key: Comparable, Value>: BinaryTreeProtocol {
    
    var key: Key
    var value: Value
    var left: RandomizedTree?
    var right: RandomizedTree?
    
    init(key: Key, value: Value, left: RandomizedTree?, right: RandomizedTree?) {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
    }
    
    func set(_ value: Value, for key: Key) -> Self {
        return self
    }
    
    func removeValue(for key: Key) -> Self? {
        return self
    }

}
