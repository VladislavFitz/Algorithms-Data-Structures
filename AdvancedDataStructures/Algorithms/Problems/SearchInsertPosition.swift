//
//  SearchInsertPosition.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 19/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

/*
 Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
 
 You may assume no duplicates in the array.
 
 https://leetcode.com/problems/search-insert-position/description/
*/

class SearchInsertPosition: Algorithm {
    
    typealias Input = (nums: [Int], target: Int)
    typealias Output = Int
    
    let input: (nums: [Int], target: Int)
    var output: Int = -1
    
    init(input: Input) {
        self.input = input
    }
    
    func perform() {
        
        let nums = input.nums
        let target = input.target
        
        func insertPosition(in nums: [Int], target: Int, leftOffset: Int = 0) -> Int {
            
            guard !nums.isEmpty else { return leftOffset }
            
            if let element = nums.first, nums.count == 1 {
                return leftOffset + (element >= target ? 0 : 1)
            }
            
            let medium = nums[nums.count/2]
            
            if target == medium  {
                return leftOffset + nums.count/2
            } else if target < medium {
                return insertPosition(in: Array(nums[0..<nums.count/2]), target: target, leftOffset: leftOffset)
            } else {
                return insertPosition(in: Array(nums[(nums.count/2)...]), target: target, leftOffset: leftOffset + nums[0..<nums.count/2].count)
            }
            
        }
        
        output = insertPosition(in: nums, target: target)
        
    }
    
}
