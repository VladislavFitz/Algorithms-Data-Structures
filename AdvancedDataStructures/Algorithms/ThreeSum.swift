//
//  ThreeSum.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 19/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

/*
 Given an array S of n integers, are there elements a, b, c in S such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.
 
 Note: The solution set must not contain duplicate triplets.
 
 For example, given array S = [-1, 0, 1, 2, -1, -4],
 
 A solution set is:
 [
 [-1, 0, 1],
 [-1, -1, 2]
 ]
 
 https://leetcode.com/problems/3sum/description/
 
*/

class ThreeSum: Algorithm {
    
    typealias Input = [Int]
    typealias Output = [[Int]]
    
    let input: [Int]
    var output: [[Int]] = []
    
    init(input: [Int]) {
        self.input = input
    }
    
    /* Solution in O(n^2) */
    
    func perform() {
        
        guard input.count > 2 else {
            return
        }
        
        let maxNum = input.max()!
        let minNum = input.min()!
        
        if minNum > 0 || maxNum < 0 {
            return
        }
        
        if maxNum == 0 || minNum == 0 {
            let containsThreeZeros = input.filter({ $0 == 0 }).count >= 3
            output = containsThreeZeros ? [[0, 0, 0]] : []
            return
        }
        
        var numsStat: [Int: Int] = [:]
        
        var resultsSet = Set<String>()
        var pairsSet = Set<String>()
        
        for element in input {
            numsStat[element] = (numsStat[element] ?? 0) + 1
        }
        
        func numsIncludes(_ subArray: [Int]) -> Bool {
            
            var subArrayStat: [Int: Int] = [:]
            for element in subArray {
                subArrayStat[element] = (subArrayStat[element] ?? 0) + 1
            }
            
            for element in subArray {
                if (numsStat[element] ?? 0) >= (subArrayStat[element] ?? 0) {
                    continue
                } else {
                    return false
                }
            }
            
            return true
            
        }
        
        var results: [[Int]] = []
        
        var pairs: [Int: [[Int]]] = [:]
        
        for i in 0..<input.endIndex {
            for j in i+1..<input.endIndex {
                let newPair = [input[i], input[j]].sorted()
                let newPairKey = "\(newPair[0]) \(newPair[1])"
                guard !pairsSet.contains(newPairKey) else { continue }
                pairsSet.insert(newPairKey)
                
                let sum = input[i] + input[j]
                if sum > 0 && sum > abs(minNum) { continue }
                if sum < 0 && abs(sum) > maxNum { continue }
                
                let existingPairs = pairs[sum] ?? []
                pairs[sum] = existingPairs + [newPair]
            }
        }
        
        for n in input {
            
            let matchingPairs = (pairs[0-n] ?? [])
            
            guard !matchingPairs.isEmpty else { continue }
            
            for pair in matchingPairs {
                let result = (pair + [n]).sorted()
                let resultKey = "\(result[0]) \(result[1]) \(result[2])"
                guard !resultsSet.contains(resultKey) else { continue }
                guard numsIncludes(result) else { continue }
                
                resultsSet.insert(resultKey)
                results.append(result)
            }
            
        }
        
        output = results

    }
    
}
