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
    public var pushDuration: TimeInterval = 0.375
    public var popDuration: TimeInterval = 0.375
    public var presentAnimationOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseInOut]
    public var dismissAnimationOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseInOut]
    public var pushAnimationOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseInOut]
    public var popAnimationOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseInOut]
    private let interactiveTransition = InteractiveTransition()

    private override init() { }

    public func handleGesture(_ gesture: UIPanGestureRecognizer, view: UIView) {
        interactiveTransition.handleGesture(gesture, view: view)
    }
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

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

extension ImageTransitionDelegate: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .none:
            return nil
        case .pop:
            return ImageTransitioning(duration: popDuration, animationOptions: popAnimationOptions)
        case .push:
            return ImageTransitioning(duration: pushDuration, animationOptions: pushAnimationOptions)
        }
    }
}
