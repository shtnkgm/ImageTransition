//
//  UIView+Tests.swift
//  ImageTransitionTests
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

@testable import ImageTransition
import XCTest

class UIView_Tests: XCTestCase {
    func test_convertFrame() {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 1_000, height: 1_000))
        let view2 = UIView(frame: CGRect(x: 100, y: 200, width: 500, height: 500))
        let view3 = UIView(frame: CGRect(x: 300, y: 400, width: 200, height: 300))
        let view4 = UIView(frame: CGRect(x: 10, y: 20, width: 30, height: 40))
        
        view1.addSubview(view2)
        view2.addSubview(view3)
        view3.addSubview(view4)
        
        let expectedFrame = CGRect(x: 410, y: 620, width: 30, height: 40)
        
        XCTAssertEqual(expectedFrame, view4.convertFrame(to: view1))
    }
    
    func test_convertCenter() {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 1_000, height: 1_000))
        let view2 = UIView(frame: CGRect(x: 100, y: 200, width: 500, height: 500))
        let view3 = UIView(frame: CGRect(x: 300, y: 400, width: 200, height: 300))
        let view4 = UIView(frame: CGRect(x: 10, y: 20, width: 30, height: 40))
        
        view1.addSubview(view2)
        view2.addSubview(view3)
        view3.addSubview(view4)
        
        let expectedCenter = CGPoint(x: 410 + 15, y: 620 + 20)
        
        XCTAssertEqual(expectedCenter, view4.convertCenter(to: view1))
    }
    
    func test_addSubviews() {
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        view1.addSubviews(view2, view3)
        XCTAssertTrue(view1.subviews.contains(view2))
        XCTAssertTrue(view1.subviews.contains(view3))
    }
}

