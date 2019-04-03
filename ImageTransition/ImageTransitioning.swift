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

        let fromViews: [UIView] = ([fromVC.view] + fromVC.view.recursiveSubviews).filter { $0.animationId != nil }
        let toViews: [UIView] = ([toVC.view] + toVC.view.recursiveSubviews).filter { $0.animationId != nil }

        let viewPairs: [(moving: UIView, from: UIView, to: UIView)] = fromViews.compactMap { from in

            guard let to = toViews.first(where: { $0.animationId == from.animationId }) else {
                return nil
            }

            if let from = from as? UILabel {
                let label = UILabel()
                label.font = from.font
                label.copyproperties(from: from)
                label.setCenter(of: from, in: fromVC.view)
                return (label, from, to)
            }

            if let from = from as? UIImageView {
                let imageView = UIImageView()
                imageView.image = from.image
                imageView.copyproperties(from: from)
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFill
                imageView.setCenter(of: from, in: fromVC.view)
                return (imageView, from, to)
            }

            let view = UIView()
            view.copyproperties(from: from)
            view.setCenter(of: from, in: fromVC.view)
            return (view, from, to)
        }

        transitionContext.containerView.backgroundColor = .white

        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.addSubviews(viewPairs.map { $0.moving })

        // Do not use "isHidden" not to animate in stackview
        viewPairs.forEach {
            $0.from.alpha = 0
            $0.to.alpha = 0
        }
        toVC.view.alpha = 0.0

        // To calculate displayImageSize correctly, recalculate the layout
        toVC.view.setNeedsLayout()
        toVC.view.layoutIfNeeded()

        let duration = transitionDuration(using: transitionContext)
        let options: UIView.AnimationOptions = animationOptions

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: options, animations: {

            // UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            toVC.view.alpha = 1.0

            viewPairs.forEach {
                if let to = $0.to as? UILabel, let from = $0.from as? UILabel {
                    let scale = to.font.pointSize / from.font.pointSize
                    ($0.moving as? UILabel)?.transform = CGAffineTransform(scaleX: scale, y: scale)
                    ($0.moving as? UILabel)?.copyproperties(from: to)
                    ($0.moving as? UILabel)?.setCenter(of: to, in: toVC.view)
                    return
                }

                if let to = $0.to as? UIImageView {
                    ($0.moving as? UIImageView)?.copyproperties(from: to)
                    ($0.moving as? UIImageView)?.setCenter(of: to, in: toVC.view)
                    return
                }

                $0.moving.copyproperties(from: $0.to)
                $0.moving.setCenter(of: $0.to, in: toVC.view)
            }

        }, completion: { _ in
            // Do not use "isHidden" not to animate in stackview
            viewPairs.forEach {
                $0.from.alpha = 1
                $0.to.alpha = 1
            }

            viewPairs.forEach {
                $0.moving.removeFromSuperview()
            }

            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

extension UIView {
    func copyproperties(from view: UIView) {
        frame.size = view.frame.size
        layer.cornerRadius = view.layer.cornerRadius
        backgroundColor = view.backgroundColor
        clipsToBounds = view.clipsToBounds
        layer.shadowRadius = view.layer.shadowRadius
        layer.shadowOffset = view.layer.shadowOffset
        layer.shadowOpacity = view.layer.shadowOpacity
    }
}

extension UIImageView {
    func copyproperties(from imageView: UIImageView) {
        frame.size = imageView.displayingImageSize
        layer.cornerRadius = imageView.layer.cornerRadius
        backgroundColor = imageView.backgroundColor
    }
}

extension UILabel {
    func copyproperties(from label: UILabel) {
        text = label.text
        frame.size = label.frame.size
        textColor = label.textColor
    }
}
