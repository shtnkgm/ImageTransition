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
        guard let fromImageTransitionable = fromVC as? ImageTransitionable else { assertionFailure("fromVC not conform to Protocol 'ImageTransitionable'"); return }
        guard let toImageTransitionable = toVC as? ImageTransitionable else { assertionFailure("toVC not conform to Protocol 'ImageTransitionable'"); return }

        guard let fromImageView = fromImageTransitionable.imageViewForTransition else { assertionFailure("fromImageView is nil"); return }
        guard let toImageView = toImageTransitionable.imageViewForTransition else { assertionFailure("toImageView is nil"); return }

        guard let fromTitleView = fromImageTransitionable.titleViewForTransition else { assertionFailure("fromTitleView is nil"); return }
        guard let toTitleView = toImageTransitionable.titleViewForTransition else { assertionFailure("toTitleView is nil"); return }

        guard let fromSubtitleView = fromImageTransitionable.subtitleViewForTransition else { assertionFailure("fromSubtitleView is nil"); return }
        guard let toSubtitleView = toImageTransitionable.subtitleViewForTransition else { assertionFailure("toSubtitleView is nil"); return }

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

        let movingTitleView = UILabel()
        movingTitleView.text = fromTitleView.text
        movingTitleView.frame.size = fromTitleView.frame.size
        movingTitleView.center = fromTitleView.convertCenter(to: fromVC.view)
        movingTitleView.font = fromTitleView.font
        movingTitleView.textColor = fromTitleView.textColor
        transitionContext.containerView.addSubviews(toVC.view, movingTitleView)

        let movingSubtitleView = UILabel()
        movingSubtitleView.text = fromSubtitleView.text
        movingSubtitleView.frame.size = fromSubtitleView.frame.size
        movingSubtitleView.center = fromSubtitleView.convertCenter(to: fromVC.view)
        movingSubtitleView.font = fromSubtitleView.font
        movingSubtitleView.textColor = fromSubtitleView.textColor
        transitionContext.containerView.addSubviews(toVC.view, movingSubtitleView)

        // Do not use "isHidden" not to animate in stackview
        fromImageView.alpha = 0.0
        toImageView.alpha = 0.0

        fromTitleView.alpha = 0.0
        toTitleView.alpha = 0.0

        fromSubtitleView.alpha = 0.0
        toSubtitleView.alpha = 0.0

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

            movingTitleView.frame.size = toTitleView.frame.size
            movingTitleView.center = toTitleView.convertCenter(to: toVC.view)
            movingTitleView.font = toTitleView.font

            movingSubtitleView.frame.size = toSubtitleView.frame.size
            movingSubtitleView.center = toSubtitleView.convertCenter(to: toVC.view)
            movingSubtitleView.font = toSubtitleView.font

        }, completion: { _ in
            // Do not use "isHidden" not to animate in stackview
            fromImageView.alpha = 1.0
            toImageView.alpha = 1.0

            fromTitleView.alpha = 1.0
            toTitleView.alpha = 1.0

            fromSubtitleView.alpha = 1.0
            toSubtitleView.alpha = 1.0

            movingView.removeFromSuperview()
            movingTitleView.removeFromSuperview()
            movingSubtitleView.removeFromSuperview()

            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
