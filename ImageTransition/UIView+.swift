//
//  UIView+.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit

internal extension UIView {
    func convertFrame(to view: UIView) -> CGRect {
        return convert(bounds, to: view)
    }

    func convertCenter(to view: UIView) -> CGPoint {
        let frame = convertFrame(to: view)
        return CGPoint(x: frame.minX + frame.width / 2.0, y: frame.minY + frame.height / 2.0)
    }

    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
