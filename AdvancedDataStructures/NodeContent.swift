//
//  NodeContent.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 27.08.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

struct NodeContent<Key: Comparable, Value> where Key: Equatable {
    var key: Key
    var value: Value
}
