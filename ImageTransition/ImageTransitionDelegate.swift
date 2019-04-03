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
    public var presentConfig = ImageTransitionConfig()
    public var dismissConfig = ImageTransitionConfig()
    public var pushConfig = ImageTransitionConfig()
    public var popConfig = ImageTransitionConfig()

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
        return ImageTransitioning(config: presentConfig)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ImageTransitioning(config: dismissConfig)
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
            return ImageTransitioning(config: popConfig)
        case .push:
            return ImageTransitioning(config: pushConfig)
        }
    }

    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}
