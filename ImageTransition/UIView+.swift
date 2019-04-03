//
//  UIView+.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit

internal extension UIView {
    internal func convertFrame(to view: UIView) -> CGRect {
        return convert(bounds, to: view)
    }

    internal func convertCenter(to view: UIView) -> CGPoint {
        let frame = convertFrame(to: view)
        return CGPoint(x: frame.minX + frame.width / 2.0, y: frame.minY + frame.height / 2.0)
    }

    internal func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}

private var animationIdKey: UInt8 = 0

extension UIView {
    var animationId: String? {
        get {
            guard let object = objc_getAssociatedObject(self, &animationIdKey) as? String else {
                return nil
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &animationIdKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

}
