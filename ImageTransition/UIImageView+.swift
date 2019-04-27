//
//  UIImageView+.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import AVFoundation
import UIKit

internal extension UIImageView {
    var displayingImageSize: CGSize {
        guard let image = image else { return .zero }
        switch contentMode {
        case .scaleAspectFit:
            return AVMakeRect(aspectRatio: image.size, insideRect: bounds).size
        default:
            return bounds.size
        }
    }
}
