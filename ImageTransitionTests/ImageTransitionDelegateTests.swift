//
//  ImageTransitionDelegateTests.swift
//  ImageTransitionTests
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import XCTest
@testable import ImageTransition

class ImageTransitionDelegateTests: XCTestCase {
    func test_animationController_forPresented() {
        let imageTransitionDelegate = ImageTransitionDelegate.shared
        XCTAssertNotNil(imageTransitionDelegate.animationController(forPresented: UIViewController(),
                                                                    presenting: UIViewController(),
                                                                    source: UIViewController()))
    }
    
    func test_animationController_forDismissed() {
        let imageTransitionDelegate = ImageTransitionDelegate.shared
        XCTAssertNotNil(imageTransitionDelegate.animationController(forDismissed: UIViewController()))
    }
}
