//
//  BinaryTreePrinter.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 05/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct BinaryTreePrinter {
    
    static func treeString<T>(_ node:T, using nodeInfo:(T)->(String,T?,T?)) -> String {
        // node value string and sub nodes
        let (stringValue, leftNode, rightNode) = nodeInfo(node)
        
        let stringValueWidth  = stringValue.count
        
        // recurse to sub nodes to obtain line blocks on left and right
        let leftTextBlock     = leftNode  == nil ? []
            : treeString(leftNode!,using:nodeInfo)
                .components(separatedBy:"\n")
        
        let rightTextBlock    = rightNode == nil ? []
            : treeString(rightNode!,using:nodeInfo)
                .components(separatedBy:"\n")
        
        // count common and maximum number of sub node lines
        let commonLines       = Swift.min(leftTextBlock.count,rightTextBlock.count)
        let subLevelLines     = Swift.max(rightTextBlock.count,leftTextBlock.count)
        
        // extend lines on shallower side to get same number of lines on both sides
        let leftSubLines      = leftTextBlock
            + Array(repeating:"", count: subLevelLines-leftTextBlock.count)
        let rightSubLines     = rightTextBlock
            + Array(repeating:"", count: subLevelLines-rightTextBlock.count)
        
        // compute location of value or link bar for all left and right sub nodes
        //   * left node's value ends at line's width
        //   * right node's value starts after initial spaces
        let leftLineWidths    = leftSubLines.map{$0.count}
        let rightLineIndents  = rightSubLines.map{$0.prefix{$0==" "}.count  }
        
        // top line value locations, will be used to determine position of current node & link bars
        let firstLeftWidth    = leftLineWidths.first   ?? 0
        let firstRightIndent  = rightLineIndents.first ?? 0
        
        
        // width of sub node link under node value (i.e. with slashes if any)
        // aims to center link bars under the value if value is wide enough
        //
        // ValueLine:    v     vv    vvvvvv   vvvvv
        // LinkLine:    / \   /  \    /  \     / \
        //
        let linkSpacing       = Swift.min(stringValueWidth, 2 - stringValueWidth % 2)
        let leftLinkBar       = leftNode  == nil ? 0 : 1
        let rightLinkBar      = rightNode == nil ? 0 : 1
        let minLinkWidth      = leftLinkBar + linkSpacing + rightLinkBar
        let valueOffset       = (stringValueWidth - linkSpacing) / 2
        
        // find optimal position for right side top node
        //   * must allow room for link bars above and between left and right top nodes
        //   * must not overlap lower level nodes on any given line (allow gap of minSpacing)
        //   * can be offset to the left if lower subNodes of right node
        //     have no overlap with subNodes of left node
        let minSpacing        = 2
        let rightNodePosition = zip(leftLineWidths,rightLineIndents[0..<commonLines])
            .reduce(firstLeftWidth + minLinkWidth)
            { Swift.max($0, $1.0 + minSpacing + firstRightIndent - $1.1) }
        
        
        // extend basic link bars (slashes) with underlines to reach left and right
        // top nodes.
        //
        //        vvvvv
        //       __/ \__
        //      L       R
        //
        let linkExtraWidth    = Swift.max(0, rightNodePosition - firstLeftWidth - minLinkWidth )
        let rightLinkExtra    = linkExtraWidth / 2
        let leftLinkExtra     = linkExtraWidth - rightLinkExtra
        
        // build value line taking into account left indent and link bar extension (on left side)
        let valueIndent       = Swift.max(0, firstLeftWidth + leftLinkExtra + leftLinkBar - valueOffset)
        let valueLine         = String(repeating:" ", count:Swift.max(0,valueIndent))
            + stringValue
        
        // build left side of link line
        let leftLink          = leftNode == nil ? ""
            : String(repeating: " ", count:firstLeftWidth)
            + String(repeating: "_", count:leftLinkExtra)
            + "/"
        
        // build right side of link line (includes blank spaces under top node value)
        let rightLinkOffset   = linkSpacing + valueOffset * (1 - leftLinkBar)
        let rightLink         = rightNode == nil ? ""
            : String(repeating:  " ", count:rightLinkOffset)
            + "\\"
            + String(repeating:  "_", count:rightLinkExtra)
        
        // full link line (will be empty if there are no sub nodes)
        let linkLine          = leftLink + rightLink
        
        // will need to offset left side lines if right side sub nodes extend beyond left margin
        // can happen if left subtree is shorter (in height) than right side subtree
        let leftIndentWidth   = Swift.max(0,firstRightIndent - rightNodePosition)
        let leftIndent        = String(repeating:" ", count:leftIndentWidth)
        let indentedLeftLines = leftSubLines.map{ $0.isEmpty ? $0 : (leftIndent + $0) }
        
        // compute distance between left and right sublines based on their value position
        // can be negative if leading spaces need to be removed from right side
        let mergeOffsets      = indentedLeftLines
            .map{$0.count}
            .map{leftIndentWidth + rightNodePosition - firstRightIndent - $0 }
            .enumerated()
            .map{ rightSubLines[$0].isEmpty ? 0  : $1 }
        
        
        // combine left and right lines using computed offsets
        //   * indented left sub lines
        //   * spaces between left and right lines
        //   * right sub line with extra leading blanks removed.
        let mergedSubLines    = zip(mergeOffsets.enumerated(),indentedLeftLines)
            .map { (indexes, string) -> (Int, Int, String) in
                let secondIndex = indexes.1
                let suffixLength = Swift.max(0, secondIndex)
                let suffix = String(repeating:" ", count: suffixLength)
                return (indexes.0, indexes.1, string + suffix)
            }
            .map { (arg) -> String in
                let (i0, i1, i2) = arg
                let toDrop = Swift.max(0,-i1)
                return i2 + String(rightSubLines[i0].dropFirst(toDrop))
        }
        // Assemble final result combining
        //  * node value string
        //  * link line (if any)
        //  * merged lines from left and right sub trees (if any)
        let result = [leftIndent + valueLine]
            + (linkLine.isEmpty ? [] : [leftIndent + linkLine])
            + mergedSubLines
        
        return result.joined(separator:"\n")
    }
    
}

extension BinaryTreeProtocol {
    
    var description: String {
        
        return BinaryTreePrinter.treeString(self, using: { (tree) in
            return ("\(nodeDescription)", tree.left, tree.right)
        })
        
    }

}
