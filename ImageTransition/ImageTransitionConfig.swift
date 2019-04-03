//
//  ImageTransitionConfig.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2019/04/04.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import Foundation

public struct ImageTransitionConfig {
    let duration: TimeInterval
    let delay: TimeInterval
    let dampingRatio: CGFloat
    let initialSpringVelocity: CGFloat
    let options: UIView.AnimationOptions

    public init(duration: TimeInterval = 0.5,
                delay: TimeInterval = 0,
                dampingRatio: CGFloat = 0.7,
                initialSpringVelocity: CGFloat = 0,
                options: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseInOut]) {
        self.duration = duration
        self.delay = delay
        self.dampingRatio = dampingRatio
        self.initialSpringVelocity = initialSpringVelocity
        self.options = options
    }
}
