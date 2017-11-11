//
//  QuickSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 02.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct QuickSort<Element>: SortAlgorithm where Element: Comparable {
    
    typealias GetPivot<Element> = (ArraySlice<Element>) -> Element where Element: Comparable
    
    var getPivot: GetPivot<Element>
    
    init(getPivot: @escaping GetPivot<Element>) {
        self.getPivot = getPivot
    }
    
    private func partition(array: inout ArraySlice<Element>) -> Int {
        
        let pivot = getPivot(array)
        
        var leftPointer = array.startIndex
        var rightPointer = array.endIndex - 1
        
        while leftPointer <= rightPointer {
            
            while array[leftPointer] < pivot {
                leftPointer = leftPointer + 1
            }
            
            while array[rightPointer] > pivot {
                rightPointer = rightPointer - 1
            }
            
            if leftPointer <= rightPointer {
                array.swapAt(leftPointer, rightPointer)
                leftPointer = leftPointer + 1
                rightPointer = rightPointer - 1
            }
            
        }
        
        return rightPointer
        
    }
    
    private func sliceQSort(array: inout ArraySlice<Element>) {
        
        if array.count == 0 || array.count == 1 {
            return
        }
        
        let pivotIndex = partition(array: &array)
        sliceQSort(array: &array[...pivotIndex])
        sliceQSort(array: &array[(pivotIndex+1)...])
        
    }
    
    func sort(_ array: [Element]) -> [Element] {
        
        var slice = ArraySlice(array)
        sliceQSort(array: &slice)
        
        return Array(slice)
        
    }
    
}
