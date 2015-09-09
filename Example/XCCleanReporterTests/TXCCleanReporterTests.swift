//
//  TXCCleanReporterTests.swift
//  TXCCleanReporterTests
//
//  Created by Andrei Raifura on 9/9/15.
//  Copyright © 2015 thelvis. All rights reserved.
//

import XCTest

class TXCCleanReporterTests: XCTestCase {
    
    func testReturnsSum_WhenGivenAnArrayOfIntegers() {
        // Given
        let integers = [1, 2, 3]
        //When
        let result = sum(integers)
        //Then
        XCTAssertEqual(result, 6)
    }
    
}

func sum(numbers: [Int]) -> Int {
    return numbers.reduce(0) { $0 + $1 }
}