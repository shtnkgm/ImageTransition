//
//  ImageTransitioning.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit

internal final class ImageTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval
    private let animationOptions: UIView.AnimationOptions

    internal init(duration: TimeInterval, animationOptions: UIView.AnimationOptions) {
        self.duration = duration
        self.animationOptions = animationOptions
    }

    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else { assertionFailure("fromVC is nil"); return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { assertionFailure("toVC is nil"); return }
        guard let fromImageView = (fromVC as? ImageTransitionable)?.imageViewForTransition else { assertionFailure("fromImageView is nil"); return }
        guard let toImageView = (toVC as? ImageTransitionable)?.imageViewForTransition else { assertionFailure("toImageView is nil"); return }
        guard let fromImage = fromImageView.image else { assertionFailure("fromImage is nil"); return }
        guard let toImage = toImageView.image else { assertionFailure("toImage is nil"); return }

        // Use image with larger size
        let movingView = UIImageView(image: fromImage.largerCompared(with: toImage))
        movingView.clipsToBounds = true
        movingView.contentMode = .scaleAspectFill
        movingView.frame.size = fromImageView.displayingImageSize
        movingView.center = fromImageView.convertCenter(to: fromVC.view)
        movingView.layer.cornerRadius = fromImageView.layer.cornerRadius

        transitionContext.containerView.addSubviews(toVC.view, movingView)

        // Do not use "isHidden" not to animate in stackview
        fromImageView.alpha = 0.0
        toImageView.alpha = 0.0
        toVC.view.alpha = 0.0

        // To calculate displayImageSize correctly, recalculate the layout
        toVC.view.setNeedsLayout()
        toVC.view.layoutIfNeeded()

        let duration = transitionDuration(using: transitionContext)
        let options: UIView.AnimationOptions = animationOptions
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            toVC.view.alpha = 1.0
            movingView.frame.size = toImageView.displayingImageSize
            movingView.center = toImageView.convertCenter(to: toVC.view)
            movingView.layer.cornerRadius = toImageView.layer.cornerRadius
        }, completion: { _ in
            // Do not use "isHidden" not to animate in stackview
            fromImageView.alpha = 1.0
            toImageView.alpha = 1.0
            movingView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
