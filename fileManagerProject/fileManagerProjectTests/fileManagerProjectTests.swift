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
        var pix = [Pix]()
        let exp = XCTestExpectation(description: "Something")
        
        GenericCoderAPI.manager.getJSON(objectType: PixWrapper.self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                XCTFail("Failure to decode JSON: \(error)")
            case .success(let wrapper):
                pix = wrapper.hits
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 5)
    }

}
