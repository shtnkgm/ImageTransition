//
//  InteractiveTransition.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2019/03/24.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit

internal final class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false

    override init() {
        super.init()
    }

    func handleGesture(_ gesture: UIPanGestureRecognizer, view: UIView) {
        let percentThreshold: CGFloat = 0.3
        let transition = gesture.translation(in: view)
        let progress = clamp(transition.y / view.bounds.height, min: 0, max: 1)

        switch gesture.state {
        case .began:
            hasStarted = true
        case .cancelled:
            hasStarted = false
        case .changed:
            update(progress)
        case .ended:
            hasStarted = false
            progress > percentThreshold ? finish() : cancel()
        case .failed:
            break
        case .possible:
            break
        }
    }
}
