//
//  fileManagerProjectTests.swift
//  fileManagerProjectTests
//
//  Created by Ahad Islam on 1/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import XCTest
@testable import fileManagerProject

class fileManagerProjectTests: XCTestCase {

    func testJSONFromEndpoint() {
        let endpointURL = "https://pixabay.com/api/?key=\(AppKey.appKey)&q=yellow+flowers"
        let pix = [Pix]()
        let exp = XCTestExpectation(description: "Something")
        
        
    }

}
