//
//  UIImageView+Tests.swift
//  ImageTransitionTests
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

@testable import ImageTransition
import XCTest

class UIImageView_Tests: XCTestCase {
    func test_displayingImageSize_画像なし() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertEqual(imageView.displayingImageSize, .zero)
    }
    
    func test_displayingImageSize_scaleAspectFitの場合_画像あり() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage.sampleImage(size: CGSize(width: 50, height: 30))
        imageView.contentMode = .scaleAspectFit
        XCTAssertEqual(imageView.displayingImageSize, CGSize(width: 100, height: 60))
    }
    
    func test_displayingImageSize_scaleAspectFillの場合_画像あり() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage.sampleImage(size: CGSize(width: 50, height: 30))
        imageView.contentMode = .scaleAspectFill
        XCTAssertEqual(imageView.displayingImageSize, CGSize(width: 100, height: 100))
    }
}

extension UIImage {
    class func sampleImage(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        
        let rect = CGRect(origin: .zero, size: size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
