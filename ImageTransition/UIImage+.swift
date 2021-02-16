//
//  UIImage+.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit

internal extension UIImage {
    var area: CGFloat {
        size.width * size.height
    }

    func largerCompared(with comparedImage: UIImage) -> UIImage {
        area > comparedImage.area ? self : comparedImage
    }
}
