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

        guard let fromBaseView = fromImageTransitionable.baseViewForTransition else { assertionFailure("fromBaseView is nil"); return }
        guard let toBaseView = toImageTransitionable.baseViewForTransition else { assertionFailure("toBaseView is nil"); return }

        guard let fromImageView = fromImageTransitionable.imageViewForTransition else { assertionFailure("fromImageView is nil"); return }
        guard let toImageView = toImageTransitionable.imageViewForTransition else { assertionFailure("toImageView is nil"); return }

        guard let fromTitleView = fromImageTransitionable.titleViewForTransition else { assertionFailure("fromTitleView is nil"); return }
        guard let toTitleView = toImageTransitionable.titleViewForTransition else { assertionFailure("toTitleView is nil"); return }

        guard let fromSubtitleView = fromImageTransitionable.subtitleViewForTransition else { assertionFailure("fromSubtitleView is nil"); return }
        guard let toSubtitleView = toImageTransitionable.subtitleViewForTransition else { assertionFailure("toSubtitleView is nil"); return }

        guard let fromImage = fromImageView.image else { assertionFailure("fromImage is nil"); return }
        guard let toImage = toImageView.image else { assertionFailure("toImage is nil"); return }

        let movingBaseView = UIView()
        movingBaseView.copyproperties(from: fromBaseView)
        movingBaseView.center = fromBaseView.convertCenter(to: fromVC.view)

        // Use image with larger size
        let movingImageView = UIImageView(image: fromImage.largerCompared(with: toImage))
        movingImageView.copyproperties(from: fromImageView)
        movingImageView.clipsToBounds = true
        movingImageView.contentMode = .scaleAspectFill
        movingImageView.center = fromImageView.convertCenter(to: fromVC.view)

        let movingTitleView = UILabel()
        movingTitleView.font = fromTitleView.font
        movingTitleView.copyproperties(from: fromTitleView)
        movingTitleView.center = fromTitleView.convertCenter(to: fromVC.view)

        let movingSubtitleView = UILabel()
        movingSubtitleView.font = fromSubtitleView.font
        movingSubtitleView.copyproperties(from: fromSubtitleView)
        movingSubtitleView.center = fromSubtitleView.convertCenter(to: fromVC.view)

        transitionContext.containerView.backgroundColor = .white
        transitionContext.containerView.addSubviews(toVC.view, movingBaseView, movingImageView, movingTitleView, movingSubtitleView)

        // Do not use "isHidden" not to animate in stackview
        fromBaseView.alpha = 0.0
        toBaseView.alpha = 0.0

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

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: options, animations: {

            // UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            toVC.view.alpha = 1.0

            let titleScale = toTitleView.font.pointSize / fromTitleView.font.pointSize
            movingTitleView.transform = CGAffineTransform(scaleX: titleScale, y: titleScale)

            let subtitleScale = toSubtitleView.font.pointSize / fromSubtitleView.font.pointSize
            movingSubtitleView.transform = CGAffineTransform(scaleX: subtitleScale, y: subtitleScale)

            movingBaseView.copyproperties(from: toBaseView)
            movingBaseView.center = toBaseView.convertCenter(to: toVC.view)

            movingImageView.copyproperties(from: toImageView)
            movingImageView.center = toImageView.convertCenter(to: toVC.view)

            movingTitleView.copyproperties(from: toTitleView)
            movingTitleView.center = toTitleView.convertCenter(to: toVC.view)

            movingSubtitleView.copyproperties(from: toSubtitleView)
            movingSubtitleView.center = toSubtitleView.convertCenter(to: toVC.view)

        }, completion: { _ in
            // Do not use "isHidden" not to animate in stackview
            fromBaseView.alpha = 1.0
            toBaseView.alpha = 1.0

            fromImageView.alpha = 1.0
            toImageView.alpha = 1.0

            fromTitleView.alpha = 1.0
            toTitleView.alpha = 1.0

            fromSubtitleView.alpha = 1.0
            toSubtitleView.alpha = 1.0

            movingBaseView.removeFromSuperview()
            movingImageView.removeFromSuperview()
            movingTitleView.removeFromSuperview()
            movingSubtitleView.removeFromSuperview()

            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

extension UIView {
    func copyproperties(from view: UIView) {
        frame.size = view.frame.size
        layer.cornerRadius = view.layer.cornerRadius
        backgroundColor = view.backgroundColor
    }
}

extension UIImageView {
    func copyproperties(from imageView: UIImageView) {
        frame.size = imageView.displayingImageSize
        layer.cornerRadius = imageView.layer.cornerRadius
        // backgroundColor = imageView.backgroundColor
    }
}

extension UILabel {
    func copyproperties(from label: UILabel) {
        text = label.text
        frame.size = label.frame.size
        textColor = label.textColor
        // font = label.font
        // backgroundColor = label.backgroundColor
    }
}
