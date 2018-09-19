//
//  UIImage+Tests.swift
//  ImageTransitionTests
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

@testable import ImageTransition
import XCTest

class UIImage_Tests: XCTestCase {
    func test_area() {
        let image = UIImage.sampleImage(size: CGSize(width: 3, height: 4))
        XCTAssertEqual(image.area, 12)
    }
    
    func test_largerCompared() {
        let small = UIImage.sampleImage(size: CGSize(width: 10, height: 10))
        let large = UIImage.sampleImage(size: CGSize(width: 100, height: 100))
        XCTAssertEqual(small.largerCompared(with: large), large)
        XCTAssertEqual(large.largerCompared(with: small), large)
    }
}
