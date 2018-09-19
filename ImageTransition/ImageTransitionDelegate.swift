//
//  ImageTransitionDelegate.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit

public final class ImageTransitionDelegate: NSObject {
    public static let shared = ImageTransitionDelegate()
    
    public var presentDuration: TimeInterval = 0.375
    public var dismissDuration: TimeInterval = 0.375
    public var presentAnimationOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseInOut]
    public var dismissAnimationOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseInOut]
    
    private override init() { }
}

extension ImageTransitionDelegate: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ImageTransitioning(duration: presentDuration, animationOptions: presentAnimationOptions)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ImageTransitioning(duration: dismissDuration, animationOptions: dismissAnimationOptions)
    }
}

