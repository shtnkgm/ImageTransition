//
//  ImageTransitioning.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2018/09/19.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit

internal final class ImageTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    private let config: ImageTransitionConfig

    internal init(config: ImageTransitionConfig) {
        self.config = config
    }

    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return config.duration
    }

    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else { assertionFailure("fromVC is nil"); return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { assertionFailure("toVC is nil"); return }
        let viewSets = makeViewSets(fromView: fromVC.view, toView: toVC.view)

        transitionContext.containerView.backgroundColor = .white
        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.addSubviews(viewSets.map { $0.moving })

        // not use "isHidden" to animate in stackview
        viewSets.forEach {
            $0.from.alpha = 0
            $0.to.alpha = 0
        }
        toVC.view.alpha = 0.0

        // to calculate displayImageSize correctly, recalculate the layout
        toVC.view.setNeedsLayout()
        toVC.view.layoutIfNeeded()

        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: config.delay,
                       usingSpringWithDamping: config.dampingRatio,
                       initialSpringVelocity: config.initialSpringVelocity,
                       options: config.options,
                       animations: {
                        toVC.view.alpha = 1.0

                        viewSets.forEach {
                            if let to = $0.to as? UILabel, let from = $0.from as? UILabel {
                                ($0.moving as? UILabel)?.transform = self.makeAffineTransform(fromView: from, toView: to)
                                ($0.moving as? UILabel)?.setProperties(of: to, parentView: toVC.view)
                                return
                            }

                            if let to = $0.to as? UIImageView {
                                ($0.moving as? UIImageView)?.setProperties(of: to, parentView: toVC.view)
                                return
                            }

                            $0.moving.setProperties(of: $0.to, parentView: toVC.view)
                        }

        }, completion: { _ in
            // not to use "isHidden" to animate in stackview
            viewSets.forEach {
                $0.from.alpha = 1
                $0.to.alpha = 1
            }

            viewSets.forEach {
                $0.moving.removeFromSuperview()
            }

            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    /// make view sets having same animation id
    private func makeViewSets(fromView: UIView, toView: UIView) -> [(moving: UIView, from: UIView, to: UIView)] {
        let fromViews: [UIView] = ([fromView] + fromView.recursiveSubviews).filter { $0.animationId != nil }
        let toViews: [UIView] = ([toView] + toView.recursiveSubviews).filter { $0.animationId != nil }

        return fromViews.compactMap { from in

            guard let to = toViews.first(where: { $0.animationId == from.animationId }) else {
                return nil
            }

            if let from = from as? UILabel {
                let label = UILabel()
                label.font = from.font
                label.setProperties(of: from, parentView: fromView)
                return (label, from, to)
            }

            if let from = from as? UIImageView {
                let imageView = UIImageView()
                imageView.setProperties(of: from, parentView: fromView)
                return (imageView, from, to)
            }

            let view = UIView()
            view.setProperties(of: from, parentView: fromView)
            return (view, from, to)
        }
    }

    private func makeAffineTransform(fromView: UIView, toView: UIView) -> CGAffineTransform {
        let fromSize = fromView.intrinsicContentSize
        let toSize = toView.intrinsicContentSize
        return CGAffineTransform(scaleX: toSize.width / fromSize.width, y: toSize.height / fromSize.height)
    }
}

fileprivate extension UIView {
    func setProperties(of view: UIView, parentView: UIView) {
        frame.size = view.frame.size
        layer.cornerRadius = view.layer.cornerRadius
        backgroundColor = view.backgroundColor ?? .clear
        clipsToBounds = view.clipsToBounds
        layer.shadowColor = view.layer.shadowColor ?? UIColor.black.cgColor
        layer.shadowRadius = view.layer.shadowRadius
        layer.shadowOffset = view.layer.shadowOffset
        layer.shadowOpacity = view.layer.shadowOpacity
        setCenter(of: view, in: parentView)
    }
}

fileprivate extension UIImageView {
    func setProperties(of view: UIImageView, parentView: UIView) {
        image = view.image
        frame.size = view.displayingImageSize
        // not to copy "clipsToBounds"
        clipsToBounds = true
        // not to copy "contentMode"
        contentMode = .scaleAspectFill

        layer.cornerRadius = view.layer.cornerRadius
        backgroundColor = view.backgroundColor ?? .clear
        setCenter(of: view, in: parentView)
    }
}

fileprivate extension UILabel {
    func setProperties(of view: UILabel, parentView: UIView) {
        text = view.text
        textColor = view.textColor

        frame.size = view.frame.size
        layer.cornerRadius = view.layer.cornerRadius
        backgroundColor = view.backgroundColor ?? .clear
        clipsToBounds = view.clipsToBounds
        layer.shadowColor = view.layer.shadowColor ?? UIColor.black.cgColor
        layer.shadowRadius = view.layer.shadowRadius
        layer.shadowOffset = view.layer.shadowOffset
        layer.shadowOpacity = view.layer.shadowOpacity
        setCenter(of: view, in: parentView)
    }
}
