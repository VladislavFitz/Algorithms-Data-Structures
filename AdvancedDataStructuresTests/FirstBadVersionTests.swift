//
//  FirstBadVersionTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav Fitc on 19/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

@testable import AdvancedDataStructures
import XCTest

class FirstBadVersionTests: XCTestCase {
    
    func testSearch() {
        let fbv = FirstBadVersion(input: 10, firstBadVersion: 5)
        fbv.perform()
        XCTAssertEqual(fbv.output, 5)
        
    }
    
}
