//
//  ImageTransitionAnimatorTests.swift
//  ImageTransitionTests
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import XCTest
@testable import ImageTransition

class ImageTransitionAnimatorTests: XCTestCase {
    func test_transitionDuration() {
        let expectedDuration = 3.0
        let imageTransitionAnimator = ImageTransitioning(duration: expectedDuration, animationOptions: .curveEaseIn)
        XCTAssertEqual(imageTransitionAnimator.transitionDuration(using: nil), expectedDuration)
    }
}
